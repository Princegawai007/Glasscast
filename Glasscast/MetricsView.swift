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
//    // Grid definition for the top 6 cards
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
//                    
//                    // MARK: - 1. Header
//                    VStack(spacing: 4) {
//                        Text(viewModel.cityName)
//                            .font(.display(size: 24, weight: .bold))
//                            .foregroundColor(.white)
//                        Text("UPDATED JUST NOW")
//                            .font(.display(size: 12, weight: .medium))
//                            .foregroundColor(.white.opacity(0.5))
//                    }
//                    .padding(.top, 20)
//                    
//                    // MARK: - 2. Big Temperature
//                    Text("\(viewModel.currentTemp)°")
//                        .font(.display(size: 80, weight: .thin))
//                        .foregroundColor(.white)
//                        .padding(.vertical, 10)
//                    
//                    // MARK: - 3. The 6-Card Grid
//                    Text("Detailed Metrics")
//                        .font(.display(size: 14, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.6))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 4)
//                    
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        metricCard(title: "HUMIDITY", value: viewModel.humidity, icon: "drop.fill", subtext: "-2%")
//                        metricCard(title: "WIND SPEED", value: viewModel.windSpeed, icon: "wind", subtext: "+3%")
//                        
//                        // UV Index with logic
//                        metricCard(title: "UV INDEX", value: String(format: "%.0f", viewModel.uvIndex), icon: "sun.max.fill", subtext: viewModel.uvIndex > 5 ? "High" : "Moderate")
//                        
//                        metricCard(title: "VISIBILITY", value: "10 km", icon: "eye.fill", subtext: "Clear")
//                        metricCard(title: "PRESSURE", value: "1012 hPa", icon: "gauge", subtext: "Stable")
//                        metricCard(title: "DEW POINT", value: "9°C", icon: "thermometer.sun.fill", subtext: "Dry air")
//                    }
//                    
//                    // MARK: - 4. Weekly Trend Chart (Separate Section)
//                    Text("Weekly Trend")
//                        .font(.display(size: 14, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.6))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 4)
//                        .padding(.top, 16)
//                    
//                    // The Bar Chart Container
//                    GlassEffectContainer(cornerRadius: 24) {
//                        HStack(alignment: .bottom, spacing: 12) {
//                            ForEach(Array(viewModel.dailyForecast.prefix(5)), id: \.id) { day in
//                                VStack(spacing: 8) {
//                                    // Temp Label
//                                    Text("\(day.maxTemp)°")
//                                        .font(.display(size: 14, weight: .bold))
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                    
//                                    // The Liquid Bar
//                                    GeometryReader { geo in
//                                        VStack {
//                                            Spacer()
//                                            Capsule()
//                                                .fill(
//                                                    LinearGradient(
//                                                        colors: [.white, .white.opacity(0.2)],
//                                                        startPoint: .top,
//                                                        endPoint: .bottom
//                                                    )
//                                                )
//                                                .frame(width: 25) // Fixed width for nice bars
//                                                .frame(height: (CGFloat(day.maxTemp) / 45.0) * geo.size.height)
//                                        }
//                                        .frame(maxWidth: .infinity)
//                                    }
//                                    .frame(height: 100)
//                                    
//                                    // Day Label
//                                    Text(viewModel.formatDay(day.date).prefix(1))
//                                        .font(.caption)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .frame(maxWidth: .infinity)
//                                }
//                                .frame(maxWidth: .infinity)
//                            }
//                        }
//                        .padding(20)
//                    }
//                    
//                    Spacer(minLength: 100)
//                }
//                .padding(24)
//            }
//        }
//    }
//    
//    // Helper View Builder for the small cards
//    func metricCard(title: String, value: String, icon: String, subtext: String) -> some View {
//        GlassEffectContainer(cornerRadius: 20) {
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text(title)
//                        .font(.caption)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white.opacity(0.6))
//                    Spacer()
//                    Image(systemName: icon)
//                        .foregroundColor(.white.opacity(0.8))
//                }
//                
//                Text(value)
//                    .font(.display(size: 24, weight: .bold))
//                    .foregroundColor(.white)
//                
//                Text(subtext)
//                    .font(.caption)
//                    .foregroundColor(subtext.contains("+") ? .green : (subtext.contains("-") ? .red : .white.opacity(0.5)))
//            }
//            .padding(16)
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
    
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        ZStack {
            AppBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 4) {
                        Text(viewModel.cityName)
                            .font(.display(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("UPDATED JUST NOW")
                            .font(.display(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.top, 20)
                    
                    Text("\(viewModel.currentTemp)°")
                        .font(.display(size: 80, weight: .thin))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                    
                    // Grid
                    Text("Detailed Metrics")
                        .font(.display(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                    
//                    LazyVGrid(columns: columns, spacing: 16) {
//                        metricCard(title: "HUMIDITY", value: viewModel.humidity, icon: "drop.fill", subtext: "-2%")
//                        metricCard(title: "WIND SPEED", value: viewModel.windSpeed, icon: "wind", subtext: "+3%")
//                        metricCard(title: "UV INDEX", value: String(format: "%.0f", viewModel.uvIndex), icon: "sun.max.fill", subtext: viewModel.uvIndex > 5 ? "High" : "Moderate")
//                        metricCard(title: "VISIBILITY", value: "10 km", icon: "eye.fill", subtext: "Clear")
//                        metricCard(title: "PRESSURE", value: "1012 hPa", icon: "gauge", subtext: "Stable")
//                        metricCard(title: "DEW POINT", value: "9°C", icon: "thermometer.sun.fill", subtext: "Dry air")
//                    }
                    LazyVGrid(columns: columns, spacing: 16) {
                                            metricCard(title: "HUMIDITY", value: viewModel.humidity, icon: "drop.fill", subtext: "-2%")
                                            
                                            metricCard(title: "WIND SPEED", value: viewModel.windSpeed, icon: "wind", subtext: "+3%")
                                            
                                            metricCard(title: "UV INDEX", value: String(format: "%.0f", viewModel.uvIndex), icon: "sun.max.fill", subtext: viewModel.uvIndex > 5 ? "High" : "Moderate")
                                            
                                            // UPDATED: Now uses dynamic Visibility
                                            metricCard(title: "VISIBILITY", value: viewModel.visibility, icon: "eye.fill", subtext: "Clear")
                                            
                                            // UPDATED: Now uses dynamic Pressure
                                            metricCard(title: "PRESSURE", value: viewModel.pressure, icon: "gauge", subtext: "Stable")
                                            
                                            // UPDATED: Now uses dynamic Dew Point / Feels Like
                                            metricCard(title: "FEELS LIKE", value: viewModel.dewPoint, icon: "thermometer.sun.fill", subtext: "Dry air")
                                        }
                    
                    // Weekly Trend Chart
                    Text("Weekly Trend")
                        .font(.display(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                        .padding(.top, 16)
                    
//                    GlassEffectContainer(cornerRadius: 24) {
//                        // FIX: Check for empty data to prevent broken charts
//                        if viewModel.dailyForecast.isEmpty {
//                            VStack {
//                                Image(systemName: "chart.bar.xaxis")
//                                    .font(.largeTitle)
//                                    .foregroundColor(.white.opacity(0.3))
//                                Text("Chart Unavailable Offline")
//                                    .font(.caption)
//                                    .foregroundColor(.white.opacity(0.5))
//                            }
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 150)
//                        } else {
//                            HStack(alignment: .bottom, spacing: 12) {
//                                ForEach(Array(viewModel.dailyForecast.prefix(5)), id: \.id) { day in
//                                    VStack(spacing: 8) {
//                                        Text("\(day.maxTemp)°")
//                                            .font(.display(size: 14, weight: .bold))
//                                            .foregroundColor(.white)
//                                            .frame(maxWidth: .infinity)
//                                        
//                                        GeometryReader { geo in
//                                            VStack {
//                                                Spacer()
//                                                Capsule()
//                                                    .fill(LinearGradient(colors: [.white, .white.opacity(0.2)], startPoint: .top, endPoint: .bottom))
//                                                    .frame(width: 25)
//                                                    .frame(height: max(10, (CGFloat(day.maxTemp) / 50.0) * geo.size.height))
//                                            }
//                                            .frame(maxWidth: .infinity)
//                                        }
//                                        .frame(height: 100)
//                                        
//                                        Text(viewModel.formatDay(day.date).prefix(1))
//                                            .font(.caption)
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(.white.opacity(0.6))
//                                            .frame(maxWidth: .infinity)
//                                    }
//                                    .frame(maxWidth: .infinity)
//                                }
//                            }
//                            .padding(20)
//                        }
//                    }
                    GlassEffectContainer(cornerRadius: 24) {
                                            if viewModel.dailyForecast.isEmpty {
                                                VStack {
                                                    Image(systemName: "chart.bar.xaxis")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.white.opacity(0.3))
                                                    Text("Chart Unavailable Offline")
                                                        .font(.caption)
                                                        .foregroundColor(.white.opacity(0.5))
                                                }
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 150)
                                            } else {
                                                HStack(alignment: .bottom, spacing: 12) {
                                                    ForEach(Array(viewModel.dailyForecast.prefix(5)), id: \.id) { day in
                                                        VStack(spacing: 8) {
                                                            // Temp Label
                                                            Text("\(day.maxTemp)°")
                                                                .font(.display(size: 14, weight: .bold))
                                                                .foregroundColor(.white)
                                                                .frame(maxWidth: .infinity)
                                                            
                                                            // Bar Area
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
                                                                        .frame(width: 25)
                                                                        // FIX: Adjust scale based on unit (50 for C, 110 for F)
                                                                        .frame(height: (CGFloat(day.maxTemp) / (viewModel.isCelsius ? 50.0 : 110.0)) * geo.size.height)
                                                                }
                                                                .frame(maxWidth: .infinity)
                                                            }
                                                            .frame(height: 100) // Keeps the chart area fixed
                                                            
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
                                        }
                    Spacer(minLength: 100)
                }
                .padding(24)
            }
        }
    }
    
    func metricCard(title: String, value: String, icon: String, subtext: String) -> some View {
        GlassEffectContainer(cornerRadius: 20) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title).font(.caption).fontWeight(.semibold).foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Image(systemName: icon).foregroundColor(.white.opacity(0.8))
                }
                Text(value).font(.display(size: 24, weight: .bold)).foregroundColor(.white)
                Text(subtext).font(.caption).foregroundColor(subtext.contains("+") ? .green : (subtext.contains("-") ? .red : .white.opacity(0.5)))
            }
            .padding(16)
        }
    }
}
