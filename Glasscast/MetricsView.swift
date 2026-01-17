//
//  MetricsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//struct MetricsView: View {
//    @ObservedObject var viewModel: HomeViewModel
//    
//    var body: some View {
//        ZStack {
//            AppBackground()
//            
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 24) {
//                    // Header
//                    VStack(spacing: 8) {
//                        Text(viewModel.cityName)
//                            .font(.display(size: 28, weight: .bold))
//                            .foregroundColor(.white)
//                        
//                        Text("Updated Just Now")
//                            .font(.display(size: 14, weight: .regular))
//                            .foregroundColor(.white.opacity(0.6))
//                    }
//                    .padding(.top, 20)
//                    .padding(.bottom, 16)
//                    
//                    // Metrics Grid (2 columns)
//                    LazyVGrid(columns: [
//                        GridItem(.flexible(), spacing: 16),
//                        GridItem(.flexible(), spacing: 16)
//                    ], spacing: 16) {
//                        // Humidity
//                        MetricCard(
//                            icon: "drop.fill",
//                            title: "Humidity",
//                            value: "\(viewModel.currentWeather?.main.humidity ?? 0)%"
//                        )
//                        
//                        // Wind
//                        MetricCard(
//                            icon: "wind",
//                            title: "Wind",
//                            value: formatWindSpeed(viewModel.currentWeather?.wind.speed ?? 0)
//                        )
//                        
//                        // UV Index (placeholder - not in free tier)
//                        MetricCard(
//                            icon: "sun.max.fill",
//                            title: "UV Index",
//                            value: "4 Mod"
//                        )
//                        
//                        // Visibility
//                        MetricCard(
//                            icon: "eye.fill",
//                            title: "Visibility",
//                            value: formatVisibility(viewModel.currentWeather?.visibility ?? 10000)
//                        )
//                        
//                        // Pressure
//                        MetricCard(
//                            icon: "gauge",
//                            title: "Pressure",
//                            value: "\(viewModel.currentWeather?.main.pressure ?? 1012) hPa"
//                        )
//                        
//                        // Dew Point (calculated placeholder)
//                        MetricCard(
//                            icon: "thermometer.sun.fill",
//                            title: "Dew Point",
//                            value: formatDewPoint()
//                        )
//                    }
//                    .padding(.horizontal, 24)
//                    
//                    // Weekly Trend Chart
//                    GlassEffectContainer(cornerRadius: 20) {
//                        VStack(spacing: 16) {
//                            Text("Weekly Trend")
//                                .font(.display(size: 20, weight: .bold))
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            
//                            // Simple Bar Chart
//                            HStack(alignment: .bottom, spacing: 12) {
//                                ForEach(0..<7) { index in
//                                    VStack(spacing: 8) {
//                                        // Bar
//                                        Capsule()
//                                            .fill(
//                                                LinearGradient(
//                                                    colors: [
//                                                        Color.primaryBrand.opacity(0.8),
//                                                        Color.primaryBrand.opacity(0.4)
//                                                    ],
//                                                    startPoint: .top,
//                                                    endPoint: .bottom
//                                                )
//                                            )
//                                            .frame(
//                                                width: 30,
//                                                height: CGFloat(80 + (index * 10) % 50)
//                                            )
//                                        
//                                        // Day Label
//                                        Text(dayLabel(for: index))
//                                            .font(.display(size: 11, weight: .medium))
//                                            .foregroundColor(.white.opacity(0.6))
//                                    }
//                                }
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 8)
//                        }
//                        .padding(20)
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//    }
//    
//    // MARK: - Helper Methods
//    private func formatWindSpeed(_ speed: Double) -> String {
//        // OpenWeatherMap returns m/s, convert to km/h
//        let kmh = speed * 3.6
//        return String(format: "%.0f km/h", kmh)
//    }
//    
//    private func formatVisibility(_ meters: Int) -> String {
//        let km = Double(meters) / 1000.0
//        return String(format: "%.1f km", km)
//    }
//    
//    private func formatDewPoint() -> String {
//        // Calculate dew point from temperature and humidity
//        // Simple approximation: T - ((100 - RH) / 5)
//        guard let temp = viewModel.currentWeather?.main.temp,
//              let humidity = viewModel.currentWeather?.main.humidity else {
//            return "9°"
//        }
//        let dewPoint = temp - ((100 - Double(humidity)) / 5.0)
//        return String(format: "%.0f°", dewPoint)
//    }
//    
//    private func dayLabel(for index: Int) -> String {
//        let calendar = Calendar.current
//        let today = Date()
//        if let day = calendar.date(byAdding: .day, value: index, to: today) {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEE"
//            return formatter.string(from: day)
//        }
//        return "Mon"
//    }
//}
//
//// MARK: - Metric Card
//struct MetricCard: View {
//    let icon: String
//    let title: String
//    let value: String
//    
//    var body: some View {
//        GlassEffectContainer(cornerRadius: 20) {
//            VStack(spacing: 12) {
//                Image(systemName: icon)
//                    .font(.system(size: 24))
//                    .foregroundColor(.primaryBrand)
//                
//                Text(title)
//                    .font(.display(size: 12, weight: .medium))
//                    .foregroundColor(.white.opacity(0.6))
//                
//                Text(value)
//                    .font(.display(size: 18, weight: .bold))
//                    .foregroundColor(.white)
//            }
//            .padding(20)
//            .frame(maxWidth: .infinity)
//        }
//        .aspectRatio(1.0, contentMode: .fit)
//    }
//}
//
//#Preview {
//    MetricsView(viewModel: HomeViewModel())
//}
//
//  MetricsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI
import UIKit

//struct MetricsView: View {
//    @ObservedObject var viewModel: HomeViewModel
//    
//    let columns = [
//        GridItem(.flexible(), spacing: 16),
//        GridItem(.flexible(), spacing: 16)
//    ]
//    
//    var body: some View {
//        ZStack {
//            // Shared Background
//            AppBackground()
//            
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 24) {
//                    // Header
//                    VStack(spacing: 4) {
//                        Text(viewModel.cityName)
//                            .font(.display(size: 24, weight: .bold))
//                            .foregroundColor(.white)
//                        Text("Updated Just Now")
//                            .font(.display(size: 12, weight: .medium))
//                            .foregroundColor(.white.opacity(0.5))
//                            .textCase(.uppercase)
//                    }
//                    .padding(.top, 20)
//                    
//                    // The Big Temperature
//                    Text("\(viewModel.currentTemp)°")
//                        .font(.display(size: 80, weight: .thin))
//                        .foregroundColor(.white)
//                        .padding(.vertical, 10)
//                    
//                    Text("Detailed Metrics")
//                        .font(.display(size: 14, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.6))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 4)
//                    
//                    // The Grid
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        metricCard(title: "HUMIDITY", value: viewModel.humidity, icon: "drop.fill", subtext: "-2%")
//                        metricCard(title: "WIND SPEED", value: viewModel.windSpeed, icon: "wind", subtext: "+3%")
//                        metricCard(title: "UV INDEX", value: String(format: "%.0f", viewModel.uvIndex), icon: "sun.max.fill", subtext: uvIndexSubtext(viewModel.uvIndex))
//                        metricCard(title: "VISIBILITY", value: "10 km", icon: "eye.fill", subtext: "Clear")
//                        metricCard(title: "PRESSURE", value: "1012 hPa", icon: "gauge", subtext: "Stable")
//                        metricCard(title: "DEW POINT", value: "9°C", icon: "thermometer.sun.fill", subtext: "Dry air")
//                    }
//                    
//                    // Weekly Trend Chart
////                    Text("Weekly Trend")
////                        .font(.display(size: 14, weight: .semibold))
////                        .foregroundColor(.white.opacity(0.6))
////                        .frame(maxWidth: .infinity, alignment: .leading)
////                        .padding(.horizontal, 4)
////                        .padding(.top, 16)
////                    
////                    GlassEffectContainer(cornerRadius: 24) {
////                        HStack(alignment: .bottom, spacing: 12) {
////                            ForEach(Array(viewModel.chartData.enumerated()), id: \.offset) { index, temp in
////                                VStack {
////                                    Spacer()
////                                    RoundedRectangle(cornerRadius: 4)
////                                        .fill(index == 0 ? Color.white : Color.white.opacity(0.2)) // Highlight today
////                                        .frame(height: chartBarHeight(temp: temp, maxTemp: viewModel.chartData.max() ?? 100))
////                                    Text(dayLabel(for: index))
////                                        .font(.caption2)
////                                        .foregroundColor(.white.opacity(0.6))
////                                }
////                            }
////                        }
////                        .padding(20)
////                        .frame(height: 180)
////                    }
//                    // Weekly Trend Chart
//                                        Text("Weekly Trend")
//                                            .font(.display(size: 14, weight: .semibold))
//                                            .foregroundColor(.white.opacity(0.6))
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .padding(.horizontal, 4)
//                                            .padding(.top, 16)
//                                        
//                                        GlassEffectContainer(cornerRadius: 24) {
//                                            HStack(alignment: .bottom, spacing: 12) {
//                                                // Use the first 5 days of real forecast data
//                                                ForEach(Array(viewModel.dailyForecast.prefix(5)), id: \.id) { day in
//                                                    VStack(spacing: 8) {
//                                                        // 1. The Temp Label (Top)
//                                                        Text("\(day.maxTemp)°")
//                                                            .font(.display(size: 14, weight: .bold))
//                                                            .foregroundColor(.white)
//                                                        
//                                                        // 2. The Liquid Bar
//                                                        GeometryReader { geo in
//                                                            VStack {
//                                                                Spacer()
//                                                                Capsule()
//                                                                    .fill(
//                                                                        LinearGradient(
//                                                                            colors: [.white, .white.opacity(0.2)],
//                                                                            startPoint: .top,
//                                                                            endPoint: .bottom
//                                                                        )
//                                                                    )
//                                                                    .frame(width: 25)
//                                                                    // Dynamic Height Calculation (Assuming 45°C is max for scaling)
//                                                                    .frame(height: (CGFloat(day.maxTemp) / 45.0) * geo.size.height)
//                                                            }
//                                                        }
//                                                        .frame(height: 100) // Max height of the bar area
//                                                        
//                                                        // 3. The Day Label (Bottom)
//                                                        Text(viewModel.formatDay(day.date).prefix(1))
//                                                            .font(.caption)
//                                                            .fontWeight(.semibold)
//                                                            .foregroundColor(.white.opacity(0.6))
//                                                    }
//                                                    .frame(maxWidth: .infinity)
//                                                }
//                                            }
//                                            .padding(20)
//                                        }
//                    
//                    Spacer(minLength: 100) // Space for Tab Bar
//                }
//                .padding(24)
//            }
//        }
//    }
//    
//    // MARK: - Helper Methods
//    private func uvIndexSubtext(_ uvIndex: Double) -> String {
//        if uvIndex > 8 {
//            return "Very High"
//        } else if uvIndex > 5 {
//            return "High"
//        } else {
//            return "Moderate/Low"
//        }
//    }
//    
//    private func chartBarHeight(temp: Double, maxTemp: Double) -> CGFloat {
//        guard maxTemp > 0 else { return 40 }
//        // Calculate relative height (40-140 range)
//        let ratio = temp / maxTemp
//        return CGFloat(40 + (ratio * 100))
//    }
//    
//    private func dayLabel(for index: Int) -> String {
//        guard index < viewModel.dailyForecast.count else {
//            return ["M", "T", "W", "T", "F", "S", "S"][index]
//        }
//        let date = viewModel.dailyForecast[index].date
//        let dayAbbr = viewModel.formatDay(date)
//        // Extract first letter for single-letter display
//        return String(dayAbbr.prefix(1))
//    }
//    
//    func metricCard(title: String, value: String, icon: String, subtext: String) -> some View {
//        Button(action: {
//            let generator = UIImpactFeedbackGenerator(style: .light)
//            generator.impactOccurred()
//        }) {
//            GlassEffectContainer(cornerRadius: 20) {
//                VStack(alignment: .leading, spacing: 12) {
//                    HStack {
//                        Text(title)
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white.opacity(0.6))
//                        Spacer()
//                        Image(systemName: icon)
//                            .foregroundColor(.white.opacity(0.8))
//                    }
//                    
//                    Text(value)
//                        .font(.display(size: 24, weight: .bold))
//                        .foregroundColor(.white)
//                    
//                    Text(subtext)
//                        .font(.caption)
//                        .foregroundColor(subtext.contains("+") ? .green : (subtext.contains("-") ? .red : .white.opacity(0.5)))
//                }
//                .padding(16)
//            }
//        }
//    }
//}


//
//  MetricsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct MetricsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    // Grid definition for the top 6 cards
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            // Shared Background
            AppBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // MARK: - 1. Header
                    VStack(spacing: 4) {
                        Text(viewModel.cityName)
                            .font(.display(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("UPDATED JUST NOW")
                            .font(.display(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.top, 20)
                    
                    // MARK: - 2. Big Temperature
                    Text("\(viewModel.currentTemp)°")
                        .font(.display(size: 80, weight: .thin))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                    
                    // MARK: - 3. The 6-Card Grid
                    Text("Detailed Metrics")
                        .font(.display(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        metricCard(title: "HUMIDITY", value: viewModel.humidity, icon: "drop.fill", subtext: "-2%")
                        metricCard(title: "WIND SPEED", value: viewModel.windSpeed, icon: "wind", subtext: "+3%")
                        
                        // UV Index with logic
                        metricCard(title: "UV INDEX", value: String(format: "%.0f", viewModel.uvIndex), icon: "sun.max.fill", subtext: viewModel.uvIndex > 5 ? "High" : "Moderate")
                        
                        metricCard(title: "VISIBILITY", value: "10 km", icon: "eye.fill", subtext: "Clear")
                        metricCard(title: "PRESSURE", value: "1012 hPa", icon: "gauge", subtext: "Stable")
                        metricCard(title: "DEW POINT", value: "9°C", icon: "thermometer.sun.fill", subtext: "Dry air")
                    }
                    
                    // MARK: - 4. Weekly Trend Chart (Separate Section)
                    Text("Weekly Trend")
                        .font(.display(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                        .padding(.top, 16)
                    
                    // The Bar Chart Container
                    GlassEffectContainer(cornerRadius: 24) {
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(Array(viewModel.dailyForecast.prefix(5)), id: \.id) { day in
                                VStack(spacing: 8) {
                                    // Temp Label
                                    Text("\(day.maxTemp)°")
                                        .font(.display(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                    
                                    // The Liquid Bar
                                    GeometryReader { geo in
                                        VStack {
                                            Spacer()
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [.white, .white.opacity(0.2)],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                                .frame(width: 25) // Fixed width for nice bars
                                                .frame(height: (CGFloat(day.maxTemp) / 45.0) * geo.size.height)
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                    .frame(height: 100)
                                    
                                    // Day Label
                                    Text(viewModel.formatDay(day.date).prefix(1))
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.6))
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(20)
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(24)
            }
        }
    }
    
    // Helper View Builder for the small cards
    func metricCard(title: String, value: String, icon: String, subtext: String) -> some View {
        GlassEffectContainer(cornerRadius: 20) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Image(systemName: icon)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Text(value)
                    .font(.display(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text(subtext)
                    .font(.caption)
                    .foregroundColor(subtext.contains("+") ? .green : (subtext.contains("-") ? .red : .white.opacity(0.5)))
            }
            .padding(16)
        }
    }
}
