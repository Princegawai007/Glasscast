//  HomeViewModel.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
import SwiftUI
internal import Combine
internal import CoreLocation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var forecast: Forecast5Response?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var uvIndex: Double = 0
    @Published var chartData: [Double] = []
    
    // MARK: - App State
    @Published var isOffline: Bool = false
    @Published var savedCities: [SavedCity] = []
    @Published var isFavorite: Bool = false
    @Published var isUserLocation: Bool = true
    
    // MARK: - Settings (Persisted)
    // This saves the user's choice to the phone's storage automatically
    @AppStorage("isCelsius") var isCelsius: Bool = true
    
    private let locationManager = LocationManager()
    private let weatherService = WeatherService.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties (With Unit Conversion)
    
    var currentTemp: Int {
        let temp = currentWeather?.main.temp ?? 0
        return isCelsius ? Int(temp) : Int(temp * 9/5 + 32)
    }
    
    var condition: String {
        currentWeather?.weather.first?.description.capitalized ?? "Clear"
    }
    
    var highLow: String {
        // Fallback
        guard let weather = currentWeather else { return "H:--° L:--°" }
        let maxT = weather.main.tempMax ?? weather.main.temp
        let minT = weather.main.tempMin ?? weather.main.temp
        
        let high = isCelsius ? Int(maxT) : Int(maxT * 9/5 + 32)
        let low = isCelsius ? Int(minT) : Int(minT * 9/5 + 32)
        return "H:\(high)° L:\(low)°"
    }
    
    var windSpeed: String {
        let speed = currentWeather?.wind.speed ?? 0
        if isCelsius {
            // Convert m/s to km/h
            return String(format: "%.0f km/h", speed * 3.6)
        } else {
            // Convert m/s to mph
            return String(format: "%.0f mph", speed * 2.237)
        }
    }
    
    var visibility: String {
        let visMeters = currentWeather?.visibility ?? 10000
        if isCelsius {
            return "\(visMeters / 1000) km"
        } else {
            // Convert meters to miles
            return String(format: "%.1f mi", Double(visMeters) / 1609.34)
        }
    }
    
    var dewPoint: String {
        // OpenWeatherMap 'current' endpoint uses 'feels_like'.
        // We will use that as a proxy for Dew Point or 'Real Feel' since it provides a temperature value.
        let val = currentWeather?.main.feelsLike ?? 0
        let temp = isCelsius ? Int(val) : Int(val * 9/5 + 32)
        return "\(temp)°"
    }
    
    var pressure: String {
        let press = currentWeather?.main.pressure ?? 1012
        if isCelsius {
            return "\(press) hPa"
        } else {
            // Convert hPa to inHg
            return String(format: "%.2f inHg", Double(press) / 33.8639)
        }
    }
    var humidity: String {
        let hum = currentWeather?.main.humidity ?? 0
        return "\(hum)%"
    }
    
    var cityName: String {
        currentWeather?.name ?? "Unknown"
    }
    
    // Forecast data grouped by day
    var dailyForecast: [DailyForecastItem] {
        guard let forecast = forecast else { return [] }
        
        let calendar = Calendar.current
        var grouped: [Date: [Forecast3Hour]] = [:]
        
        for item in forecast.list {
            let date = Date(timeIntervalSince1970: item.dt)
            let day = calendar.startOfDay(for: date)
            if grouped[day] == nil { grouped[day] = [] }
            grouped[day]?.append(item)
        }
        
        let sortedDays = grouped.keys.sorted()
        
        let forecastItems = sortedDays.prefix(5).compactMap { day -> DailyForecastItem? in
            guard let items = grouped[day], !items.isEmpty else { return nil }
            
            let temps = items.map { $0.main.temp }
            let maxTempRaw = temps.max() ?? 0
            let minTempRaw = temps.min() ?? 0
            
            // CONVERT UNITS HERE
            let maxTemp = isCelsius ? Int(maxTempRaw) : Int(maxTempRaw * 9/5 + 32)
            let minTemp = isCelsius ? Int(minTempRaw) : Int(minTempRaw * 9/5 + 32)
            
            let midIndex = min(items.count / 2, items.count - 1)
            guard midIndex >= 0 else { return nil }
            let weather = items[midIndex].weather.first
            
            return DailyForecastItem(
                date: day,
                maxTemp: maxTemp,
                minTemp: minTemp,
                condition: weather?.main ?? "Clear",
                icon: weather?.icon ?? "01d"
            )
        }
        
        return Array(forecastItems)
    }
    
    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                guard let self = self else { return }
                if self.isUserLocation {
                    Task { @MainActor in
                        await self.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                    }
                }
            }
            .store(in: &cancellables)
        
        locationManager.$authorizationStatus
            .sink { [weak self] status in
                guard let self = self else { return }
                if status == .denied || status == .restricted {
                    Task { @MainActor in
                        if self.currentWeather == nil { await self.loadWeather() }
                    }
                }
            }
            .store(in: &cancellables)
        
        locationManager.requestLocation()
        fetchFavorites()
    }
    
    func requestUserLocation() {
        isLoading = true
        isUserLocation = true
        locationManager.requestLocation()
    }
    
    func refreshWeather() async {
        if let location = locationManager.location {
            await loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        } else {
            await loadWeather()
        }
    }
    
    func loadWeather(lat: Double = 37.7749, lon: Double = -122.4194) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try Task.checkCancellation()
            async let weatherTask = weatherService.fetchWeather(lat: lat, lon: lon)
            async let forecastTask = weatherService.fetchForecast(lat: lat, lon: lon)
            async let uvTask = weatherService.fetchUV(lat: lat, lon: lon)
            
            let (weather, forecastData, uv) = try await (weatherTask, forecastTask, uvTask)
            
            await MainActor.run {
                self.currentWeather = weather
                self.forecast = forecastData
                self.uvIndex = uv
                self.isOffline = false
                self.errorMessage = nil
                self.checkIfFavorite()
                self.calculateChartData()
                self.isLoading = false
            }
        } catch {
            if error is CancellationError || (error as? URLError)?.code == .cancelled {
                await MainActor.run { self.isLoading = false }
                return
            }
            await MainActor.run {
                self.isLoading = false
                if let urlError = error as? URLError,
                   [.notConnectedToInternet, .networkConnectionLost, .timedOut].contains(urlError.code) {
                    self.errorMessage = "No Internet Connection"
                    self.isOffline = true
                } else {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func previewCity(_ city: City) async {
        isUserLocation = false
        await loadWeather(lat: city.lat, lon: city.lon)
    }
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, h:mm a"
        return formatter.string(from: Date())
    }
    
    func formatDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    func calculateChartData() {
        let next5Days = Array(dailyForecast.prefix(5))
        self.chartData = next5Days.map { Double($0.maxTemp) }
    }
    
    func fetchFavorites() {
        Task {
            do {
                self.savedCities = try await FavoritesService.shared.fetchFavorites()
                self.checkIfFavorite()
            } catch { print("Error fetching favorites: \(error)") }
        }
    }
    
    func toggleFavorite() {
        Task {
            do {
                if isFavorite {
                    if let cityToDelete = savedCities.first(where: { $0.name == cityName }) {
                        try await FavoritesService.shared.removeFavorite(id: cityToDelete.id)
                    }
                } else {
                    guard let weather = currentWeather else { return }
                    try await FavoritesService.shared.addFavorite(
                        name: weather.name,
                        lat: weather.coord.lat,
                        lon: weather.coord.lon,
                        country: weather.sys?.country ?? ""
                    )
                }
                fetchFavorites()
            } catch { print("Error toggling favorite: \(error)") }
        }
    }
    
    func checkIfFavorite() {
        if let currentName = currentWeather?.name {
            self.isFavorite = savedCities.contains { $0.name == currentName }
        } else {
            self.isFavorite = false
        }
    }
}

// MARK: - DailyForecastItem
struct DailyForecastItem: Identifiable {
    let id = UUID()
    let date: Date
    let maxTemp: Int
    let minTemp: Int
    let condition: String
    let icon: String
}
