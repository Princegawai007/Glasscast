//
//  HomeViewModel.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var forecast: Forecast5Response?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Computed properties for easy access
    var currentTemp: Int {
        Int(currentWeather?.main.temp ?? 0)
    }
    
    var condition: String {
        currentWeather?.weather.first?.description.capitalized ?? "Clear"
    }
    
    var highLow: String {
        guard let weather = currentWeather else { return "H:--° L:--°" }
        let high = Int(weather.main.tempMax ?? weather.main.temp)
        let low = Int(weather.main.tempMin ?? weather.main.temp)
        return "H:\(high)° L:\(low)°"
    }
    
    var windSpeed: String {
        let speed = currentWeather?.wind?.speed ?? 0
        // OpenWeatherMap returns m/s, convert to mph
        let mph = speed * 2.237
        return String(format: "%.0f mph", mph)
    }
    
    var humidity: String {
        let hum = currentWeather?.main.humidity ?? 0
        return "\(hum)%"
    }
    
    var cityName: String {
        currentWeather?.name ?? "Unknown"
    }
    
    // Forecast data grouped by day
//    var dailyForecast: [DailyForecastItem] {
//        guard let forecast = forecast else {
//            // Return dummy data if no forecast
//            return generateDummyForecast()
//        }
//        
//        // Group forecast items by day
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
//        // Convert to daily forecast items
//        let sortedDays = grouped.keys.sorted()
//        let forecastItems = sortedDays.prefix(5).compactMap { day in
//            guard let items = grouped[day] else { return nil }
//            
//            // Get the max and min temps for the day
//            let temps = items.map { $0.main.temp }
//            let maxTemp = temps.max() ?? 0
//            let minTemp = temps.min() ?? 0
//            
//            // Get the most representative weather condition (usually the middle of day)
//            let midIndex = min(items.count / 2, items.count - 1)
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
//        // Ensure we have at least 5 days (fill with dummy if needed)
//        if forecastItems.count < 5 {
//            var result = forecastItems
//            let today = calendar.startOfDay(for: Date())
//            for i in forecastItems.count..<5 {
//                if let nextDay = calendar.date(byAdding: .day, value: i, to: today) {
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
//        return forecastItems
//    }
    // Forecast data grouped by day
        var dailyForecast: [DailyForecastItem] {
            guard let forecast = forecast else {
                // Return dummy data if no forecast
                return generateDummyForecast()
            }
            
            // Group forecast items by day
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
            
            // Convert to daily forecast items
            let sortedDays = grouped.keys.sorted()
            
            // FIX: Added '-> DailyForecastItem?' to explicitly tell the compiler the return type
            let forecastItems = sortedDays.prefix(5).compactMap { day -> DailyForecastItem? in
                guard let items = grouped[day], !items.isEmpty else { return nil }
                
                // Get the max and min temps for the day
                let temps = items.map { $0.main.temp }
                let maxTemp = temps.max() ?? 0
                let minTemp = temps.min() ?? 0
                
                // Get the most representative weather condition (usually the middle of day)
                let midIndex = min(items.count / 2, items.count - 1)
                // Safety check for index
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
            
            // Ensure we have at least 5 days (fill with dummy if needed)
            if forecastItems.count < 5 {
                var result = forecastItems
                let today = calendar.startOfDay(for: Date())
                
                // Calculate how many we need
                let needed = 5 - forecastItems.count
                
                for i in 1...needed {
                    // Add days after the last available day
                    let baseDate = forecastItems.last?.date ?? today
                    if let nextDay = calendar.date(byAdding: .day, value: 1, to: baseDate) {
                         result.append(DailyForecastItem(
                            date: nextDay,
                            maxTemp: 72,
                            minTemp: 60,
                            condition: "Clear",
                            icon: "01d"
                        ))
                    }
                }
                return result
            }
            
            return Array(forecastItems)
        }
    
    private func generateDummyForecast() -> [DailyForecastItem] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<5).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else { return nil }
            return DailyForecastItem(
                date: date,
                maxTemp: 75 - offset,
                minTemp: 62 - offset,
                condition: ["Clear", "Clouds", "Clear", "Rain", "Clear"][offset],
                icon: ["01d", "02d", "01d", "10d", "01d"][offset]
            )
        }
    }
    
    func loadWeather(lat: Double = 37.7749, lon: Double = -122.4194) async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let weatherTask = WeatherService.shared.fetchWeather(lat: lat, lon: lon)
            async let forecastTask = WeatherService.shared.fetchForecast(lat: lat, lon: lon)
            
            let (weather, forecastData) = try await (weatherTask, forecastTask)
            
            self.currentWeather = weather
            self.forecast = forecastData
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error loading weather: \(error.localizedDescription)")
            // Keep existing data or use dummy data fallback
            if currentWeather == nil {
                // Only use dummy data if we have no data at all
            }
        }
        
        isLoading = false
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
