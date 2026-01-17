//  HomeViewModel.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import Foundation
//import SwiftUI
//internal import Combine
//internal import CoreLocation
//
//@MainActor
//class HomeViewModel: ObservableObject {
//    @Published var currentWeather: CurrentWeatherResponse?
//    @Published var forecast: Forecast5Response?
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    @Published var uvIndex: Double = 0
//    @Published var chartData: [Double] = []
//    
//    // MARK: - Favorites State
//    @Published var savedCities: [SavedCity] = []
//    @Published var isFavorite: Bool = false
//    
//    // MARK: - Location State
//    @Published var isUserLocation: Bool = true // Default to true on launch
//    
//    private let locationManager = LocationManager()
//    private let weatherService = WeatherService.shared
//    private var cancellables = Set<AnyCancellable>()
//    
//    // Computed properties for easy access
//    var currentTemp: Int {
//        Int(currentWeather?.main.temp ?? 0)
//    }
//    
//    var condition: String {
//        currentWeather?.weather.first?.description.capitalized ?? "Clear"
//    }
//    
//    var highLow: String {
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        
//        if let todayForecast = dailyForecast.first(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
//            return "H:\(todayForecast.maxTemp)° L:\(todayForecast.minTemp)°"
//        }
//        
//        guard let weather = currentWeather else { return "H:--° L:--°" }
//        let high = Int(weather.main.tempMax ?? weather.main.temp)
//        let low = Int(weather.main.tempMin ?? weather.main.temp)
//        return "H:\(high)° L:\(low)°"
//    }
//    
//    var windSpeed: String {
//        let speed = currentWeather?.wind.speed ?? 0
//        let mph = speed * 2.237
//        return String(format: "%.0f mph", mph)
//    }
//    
//    var humidity: String {
//        let hum = currentWeather?.main.humidity ?? 0
//        return "\(hum)%"
//    }
//    
//    var cityName: String {
//        currentWeather?.name ?? "Unknown"
//    }
//    
//    // Forecast data grouped by day
//    var dailyForecast: [DailyForecastItem] {
//        guard let forecast = forecast else {
//            return generateDummyForecast()
//        }
//        
//        let calendar = Calendar.current
//        var grouped: [Date: [Forecast3Hour]] = [:]
//        
//        for item in forecast.list {
//            let date = Date(timeIntervalSince1970: item.dt)
//            let day = calendar.startOfDay(for: date)
//            if grouped[day] == nil {
//                grouped[day] = []
//            }
//            grouped[day]?.append(item)
//        }
//        
//        let sortedDays = grouped.keys.sorted()
//        
//        let forecastItems = sortedDays.prefix(5).compactMap { day -> DailyForecastItem? in
//            guard let items = grouped[day], !items.isEmpty else { return nil }
//            
//            let temps = items.map { $0.main.temp }
//            let maxTemp = temps.max() ?? 0
//            let minTemp = temps.min() ?? 0
//            
//            let midIndex = min(items.count / 2, items.count - 1)
//            guard midIndex >= 0 else { return nil }
//            
//            let weather = items[midIndex].weather.first
//            
//            return DailyForecastItem(
//                date: day,
//                maxTemp: Int(maxTemp.rounded()),
//                minTemp: Int(minTemp.rounded()),
//                condition: weather?.main ?? "Clear",
//                icon: weather?.icon ?? "01d"
//            )
//        }
//        
//        if forecastItems.count < 5 {
//            var result = forecastItems
//            let today = calendar.startOfDay(for: Date())
//            let needed = 5 - forecastItems.count
//            
//            for i in 1...needed {
//                let baseDate = forecastItems.last?.date ?? today
//                if let nextDay = calendar.date(byAdding: .day, value: 1, to: baseDate) {
//                    result.append(DailyForecastItem(
//                        date: nextDay,
//                        maxTemp: 72,
//                        minTemp: 60,
//                        condition: "Clear",
//                        icon: "01d"
//                    ))
//                }
//            }
//            return result
//        }
//        
//        return Array(forecastItems)
//    }
//    
//    private func generateDummyForecast() -> [DailyForecastItem] {
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        return (0..<5).compactMap { offset in
//            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else { return nil }
//            return DailyForecastItem(
//                date: date,
//                maxTemp: 75 - offset,
//                minTemp: 62 - offset,
//                condition: ["Clear", "Clouds", "Clear", "Rain", "Clear"][offset],
//                icon: ["01d", "02d", "01d", "10d", "01d"][offset]
//            )
//        }
//    }
//    
//    init() {
//        locationManager.$location
//            .compactMap { $0 }
//            .sink { [weak self] location in
//                guard let self = self else { return }
//                
//                // Only auto-update if we are in "User Location" mode
//                if self.isUserLocation {
//                    Task { @MainActor in
//                        await self.loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
//                    }
//                }
//            }
//            .store(in: &cancellables)
//        
//        locationManager.$authorizationStatus
//            .sink { [weak self] status in
//                guard let self = self else { return }
//                if status == .denied || status == .restricted {
//                    Task { @MainActor in
//                        if self.currentWeather == nil {
//                            await self.loadWeather()
//                        }
//                    }
//                }
//            }
//            .store(in: &cancellables)
//        
//        locationManager.requestLocation()
//        fetchFavorites()
//    }
//    
//    // Function to reset to GPS location
//    func requestUserLocation() {
//        isLoading = true
//        isUserLocation = true
//        locationManager.requestLocation()
//    }
//    
//    func loadWeather(lat: Double = 37.7749, lon: Double = -122.4194) async {
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            async let weatherTask = weatherService.fetchWeather(lat: lat, lon: lon)
//            async let forecastTask = weatherService.fetchForecast(lat: lat, lon: lon)
//            async let uvTask = weatherService.fetchUV(lat: lat, lon: lon)
//            
//            let (weather, forecastData, uv) = try await (weatherTask, forecastTask, uvTask)
//            
//            self.currentWeather = weather
//            self.forecast = forecastData
//            self.uvIndex = uv
//            
//            self.checkIfFavorite()
//            calculateChartData()
//        } catch {
//            self.errorMessage = error.localizedDescription
//            print("Error loading weather: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//    
//    func previewCity(_ city: City) async {
//        isUserLocation = false // Flag that this is a manually selected city
//        await loadWeather(lat: city.lat, lon: city.lon)
//    }
//    
//    func formatDate() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, h:mm a"
//        return formatter.string(from: Date())
//    }
//    
//    func formatDay(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEE"
//        return formatter.string(from: date)
//    }
//    
//    func calculateChartData() {
//        let next5Days = Array(dailyForecast.prefix(5))
//        self.chartData = next5Days.map { Double($0.maxTemp) }
//    }
//    
//    // MARK: - Favorites Logic
//    
//    func fetchFavorites() {
//        Task {
//            do {
//                self.savedCities = try await FavoritesService.shared.fetchFavorites()
//                self.checkIfFavorite()
//            } catch {
//                print("Error fetching favorites: \(error)")
//            }
//        }
//    }
//    
//    func toggleFavorite() {
//        Task {
//            do {
//                if isFavorite {
//                    if let cityToDelete = savedCities.first(where: { $0.name == cityName }) {
//                        try await FavoritesService.shared.removeFavorite(id: cityToDelete.id)
//                    }
//                } else {
//                    guard let weather = currentWeather else { return }
//                    try await FavoritesService.shared.addFavorite(
//                        name: weather.name,
//                        lat: weather.coord.lat,
//                        lon: weather.coord.lon,
//                        country: weather.sys?.country ?? ""
//                    )
//                }
//                fetchFavorites()
//            } catch {
//                print("Error toggling favorite: \(error)")
//            }
//        }
//    }
//    
//    func checkIfFavorite() {
//        if let currentName = currentWeather?.name {
//            self.isFavorite = savedCities.contains { $0.name == currentName }
//        } else {
//            self.isFavorite = false
//        }
//    }
//}
//
//// MARK: - DailyForecastItem
//struct DailyForecastItem: Identifiable {
//    let id = UUID()
//    let date: Date
//    let maxTemp: Int
//    let minTemp: Int
//    let condition: String
//    let icon: String
//}
//
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
    @Published var isOffline: Bool = false // NEW: Tracks internet status
    @Published var savedCities: [SavedCity] = []
    @Published var isFavorite: Bool = false
    @Published var isUserLocation: Bool = true
    
    private let locationManager = LocationManager()
    private let weatherService = WeatherService.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var currentTemp: Int {
        Int(currentWeather?.main.temp ?? 0)
    }
    
    var condition: String {
        currentWeather?.weather.first?.description.capitalized ?? "Clear"
    }
    
    var highLow: String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let todayForecast = dailyForecast.first(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            return "H:\(todayForecast.maxTemp)° L:\(todayForecast.minTemp)°"
        }
        
        guard let weather = currentWeather else { return "H:--° L:--°" }
        let high = Int(weather.main.tempMax ?? weather.main.temp)
        let low = Int(weather.main.tempMin ?? weather.main.temp)
        return "H:\(high)° L:\(low)°"
    }
    
    var windSpeed: String {
        let speed = currentWeather?.wind.speed ?? 0
        // FIX: Convert m/s to km/h (since you use Celsius)
        let kmh = speed * 3.6
        return String(format: "%.0f km/h", kmh)
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
        guard let forecast = forecast else {
            // FIX: Return empty if offline, don't show confusing dummy data
            return []
        }
        
        let calendar = Calendar.current
        var grouped: [Date: [Forecast3Hour]] = [:]
        
        for item in forecast.list {
            let date = Date(timeIntervalSince1970: item.dt)
            let day = calendar.startOfDay(for: date)
            if grouped[day] == nil {
                grouped[day] = []
            }
            grouped[day]?.append(item)
        }
        
        let sortedDays = grouped.keys.sorted()
        
        let forecastItems = sortedDays.prefix(5).compactMap { day -> DailyForecastItem? in
            guard let items = grouped[day], !items.isEmpty else { return nil }
            
            let temps = items.map { $0.main.temp }
            let maxTemp = temps.max() ?? 0
            let minTemp = temps.min() ?? 0
            
            let midIndex = min(items.count / 2, items.count - 1)
            guard midIndex >= 0 else { return nil }
            
            let weather = items[midIndex].weather.first
            
            return DailyForecastItem(
                date: day,
                maxTemp: Int(maxTemp.rounded()),
                minTemp: Int(minTemp.rounded()),
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
                        if self.currentWeather == nil {
                            await self.loadWeather()
                        }
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
    
    // NEW: Pull to Refresh Action
    func refreshWeather() async {
        if let location = locationManager.location {
            await loadWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        } else {
            await loadWeather()
        }
    }
    
//    func loadWeather(lat: Double = 37.7749, lon: Double = -122.4194) async {
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            async let weatherTask = weatherService.fetchWeather(lat: lat, lon: lon)
//            async let forecastTask = weatherService.fetchForecast(lat: lat, lon: lon)
//            async let uvTask = weatherService.fetchUV(lat: lat, lon: lon)
//            
//            let (weather, forecastData, uv) = try await (weatherTask, forecastTask, uvTask)
//            
//            self.currentWeather = weather
//            self.forecast = forecastData
//            self.uvIndex = uv
//            self.isOffline = false // Success!
//            
//            self.checkIfFavorite()
//            calculateChartData()
//        } catch {
//            self.errorMessage = "No Internet Connection"
//            self.isOffline = true // Failed!
//            print("Error loading weather: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
    func loadWeather(lat: Double = 37.7749, lon: Double = -122.4194) async {
            isLoading = true
            
            // 1. Clear previous errors ONLY if we are starting a fresh request
            // Don't clear 'isOffline' yet in case we fail immediately,
            // but clearing errorMessage hides the banner while loading.
            errorMessage = nil
            
            do {
                // Using Task.checkCancellation() prevents continuing if view disappeared
                try Task.checkCancellation()
                
                async let weatherTask = weatherService.fetchWeather(lat: lat, lon: lon)
                async let forecastTask = weatherService.fetchForecast(lat: lat, lon: lon)
                async let uvTask = weatherService.fetchUV(lat: lat, lon: lon)
                
                let (weather, forecastData, uv) = try await (weatherTask, forecastTask, uvTask)
                
                // 2. Success!
                await MainActor.run {
                    self.currentWeather = weather
                    self.forecast = forecastData
                    self.uvIndex = uv
                    self.isOffline = false // Connection confirmed
                    self.errorMessage = nil
                    
                    self.checkIfFavorite()
                    self.calculateChartData()
                    self.isLoading = false
                }
                
            } catch {
                // 3. SPECIAL FIX: Ignore "Cancellation" errors
                // This happens when you pull-to-refresh while a request is already running.
                // We simply return and do NOT set isOffline = true.
                if error is CancellationError || (error as? URLError)?.code == .cancelled {
                    print("Request cancelled (likely pull-to-refresh). Ignoring.")
                    await MainActor.run { self.isLoading = false }
                    return
                }
                
                // 4. Handle Real Errors
                print("Real Error: \(error.localizedDescription)")
                await MainActor.run {
                    self.isLoading = false
                    
                    // Only show "No Internet" if it's actually a network error
                    if let urlError = error as? URLError,
                       [.notConnectedToInternet, .networkConnectionLost, .timedOut].contains(urlError.code) {
                        self.errorMessage = "No Internet Connection"
                        self.isOffline = true
                    } else {
                        // Show the REAL error (e.g., "Decoding Error", "Invalid API Key")
                        // This helps you debug if it's not just the internet.
                        self.errorMessage = error.localizedDescription
                        // We don't set isOffline = true here because the internet might be fine,
                        // but the API might be broken.
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
    
    // MARK: - Favorites
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
