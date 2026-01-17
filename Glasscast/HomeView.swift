//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

//struct HomeView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    
//    var body: some View {
//        ZStack {
//            // Background
//            AppBackground()
//            
//            // Main Content
//            VStack(spacing: 0) {
//                // Header
//                headerView
//                
//                // Main Content Area
//                ScrollView {
//                    VStack(spacing: 0) {
//                        // Hero Temperature Card
//                        heroCardView
//                            .padding(.top, 32)
//                            .padding(.bottom, 40)
//                        
//                        // Forecast Section
//                        forecastSectionView
//                            .padding(.horizontal, 24)
//                        
//                        // Map Hint
//                        mapHintView
//                            .padding(.horizontal, 24)
//                            .padding(.top, 32)
//                    }
//                }
//                
//                // Footer (Swipe Indicator)
////                footerView
//            }
//        }
//        .task {
//            await viewModel.loadWeather()
//        }
//    }
//    
//    // MARK: - Header View
////    private var headerView: some View {
////        HStack {
////            // Search Button
////            Button(action: {}) {
////                Image(systemName: "magnifyingglass")
////                    .font(.system(size: 20))
////                    .foregroundColor(.white)
////                    .frame(width: 48, height: 48)
////                    .background(
////                        Circle()
////                            .glassEffect()
////                    )
////            }
////            
////            Spacer()
////            
////            // City and Date
////            VStack(spacing: 4) {
////                Text(viewModel.cityName)
////                    .font(.display(size: 18, weight: .bold))
////                    .foregroundColor(.white)
////                
////                Text(viewModel.formatDate())
////                    .font(.display(size: 10, weight: .medium))
////                    .foregroundColor(.white.opacity(0.6))
////                    .textCase(.uppercase)
////                    .tracking(2)
////            }
////            
////            Spacer()
////            
////            // Menu Button
////            Button(action: {}) {
////                Image(systemName: "line.3.horizontal")
////                    .font(.system(size: 20))
////                    .foregroundColor(.white)
////                    .frame(width: 48, height: 48)
////                    .background(
////                        Circle()
////                            .glassEffect()
////                    )
////            }
////        }
////        .padding(.horizontal, 24)
////        .padding(.vertical, 24)
////    }
//    
//    // MARK: - Header View
//    // MARK: - Header View
//        private var headerView: some View {
//            HStack {
//                // Search Button (Left)
//                Button(action: { }) {
//                    Image(systemName: "magnifyingglass")
//                        .font(.system(size: 20))
//                        .foregroundColor(.white)
//                        .frame(width: 50, height: 50)
//                        .background(
//                            ZStack {
//                                Circle().fill(.ultraThinMaterial) // The Blur
//                                Circle().fill(Color.white.opacity(0.1)) // Subtle Tint
//                                Circle().stroke(Color.white.opacity(0.3), lineWidth: 1) // Border
//                            }
//                        )
//                        // No clipShape needed if using Circle() in background, but safe to keep
//                }
//
//                Spacer()
//
//                // City and Date (Center)
//                VStack(spacing: 4) {
//                    Text(viewModel.cityName)
//                        .font(.display(size: 18, weight: .bold))
//                        .foregroundColor(.white)
//                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
//
//                    Text(viewModel.formatDate())
//                        .font(.display(size: 11, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.7))
//                        .textCase(.uppercase)
//                        .tracking(1.5)
//                }
//
//                Spacer()
//
//                // Menu Button (Right)
//                Button(action: { }) {
//                    Image(systemName: "line.3.horizontal")
//                        .font(.system(size: 20))
//                        .foregroundColor(.white)
//                        .frame(width: 50, height: 50)
//                        .background(
//                            ZStack {
//                                Circle().fill(.ultraThinMaterial)
//                                Circle().fill(Color.white.opacity(0.1))
//                                Circle().stroke(Color.white.opacity(0.3), lineWidth: 1)
//                            }
//                        )
//                }
//            }
//            .padding(.horizontal, 24)
//            .padding(.vertical, 20)
//        }
//    
//    // MARK: - Hero Card View
//    private var heroCardView: some View {
//        GlassEffectContainer(cornerRadius: 16) {
//            VStack(spacing: 0) {
//                // Large Temperature
//                Text("\(viewModel.currentTemp)°")
//                    .font(.display(size: 110, weight: .thin))
//                    .foregroundColor(.white)
//                    .tracking(-2)
//                    .padding(.vertical, 16)
//                
//                // Condition and High/Low
//                VStack(spacing: 4) {
//                    Text(viewModel.condition)
//                        .font(.display(size: 24, weight: .light))
//                        .foregroundColor(.white)
//                        .tracking(0.5)
//                    
//                    Text(viewModel.highLow)
//                        .font(.display(size: 16, weight: .regular))
//                        .foregroundColor(.white.opacity(0.5))
//                }
//                
//                // Wind and Humidity Pills
//                HStack(spacing: 16) {
//                    // Wind
//                    HStack(spacing: 8) {
//                        Image(systemName: "wind")
//                            .font(.system(size: 14))
//                            .foregroundColor(.white.opacity(0.6))
//                        Text(viewModel.windSpeed)
//                            .font(.display(size: 12, weight: .medium))
//                            .foregroundColor(.white)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//                    .background(
//                        Capsule()
//                            .fill(Color.white.opacity(0.1))
//                            .overlay(
//                                Capsule()
//                                    .strokeBorder(Color.white.opacity(0.05), lineWidth: 1)
//                            )
//                    )
//                    
//                    // Humidity
//                    HStack(spacing: 8) {
//                        Image(systemName: "drop.fill")
//                            .font(.system(size: 14))
//                            .foregroundColor(.white.opacity(0.6))
//                        Text(viewModel.humidity)
//                            .font(.display(size: 12, weight: .medium))
//                            .foregroundColor(.white)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 8)
//                    .background(
//                        Capsule()
//                            .fill(Color.white.opacity(0.1))
//                            .overlay(
//                                Capsule()
//                                    .strokeBorder(Color.white.opacity(0.05), lineWidth: 1)
//                            )
//                    )
//                }
//                .padding(.top, 32)
//            }
//            .padding(32)
//        }
//        .padding(.horizontal, 24)
//    }
//    
//    // MARK: - Forecast Section View
//    private var forecastSectionView: some View {
//        VStack(spacing: 0) {
//            // Section Header
//            HStack {
//                Text("5-Day Forecast")
//                    .font(.display(size: 18, weight: .bold))
//                    .foregroundColor(.white)
//                
//                Spacer()
//                
//                Button("Details") {
//                    // Navigate to details
//                }
//                .font(.display(size: 14, weight: .semibold))
//                .foregroundColor(.primary)
//            }
//            .padding(.horizontal, 8)
//            .padding(.bottom, 16)
//            
//            // Forecast List
//            VStack(spacing: 12) {
//                ForEach(Array(viewModel.dailyForecast.enumerated()), id: \.element.id) { index, day in
//                    forecastDayRow(day: day, isActive: index == 1)
//                }
//            }
//        }
//    }
//    
//    // MARK: - Forecast Day Row
//    private func forecastDayRow(day: DailyForecastItem, isActive: Bool) -> some View {
//        GlassEffectContainer(cornerRadius: 16) {
//            HStack {
//                // Day Name
//                Text(viewModel.formatDay(day.date))
//                    .font(.display(size: 16, weight: isActive ? .bold : .medium))
//                    .foregroundColor(isActive ? .white : .white.opacity(0.8))
//                    .frame(width: 64, alignment: .leading)
//                
//                Spacer()
//                
//                // Weather Icon
//                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.icon)@2x.png")) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                } placeholder: {
//                    Image(systemName: weatherIconName(for: day.condition))
//                        .font(.system(size: 24))
//                        .foregroundColor(weatherIconColor(for: day.condition))
//                }
//                .frame(width: 32, height: 32)
//                
//                Spacer()
//                
//                // Temperatures
//                HStack(spacing: 12) {
//                    Text("\(day.maxTemp)°")
//                        .font(.display(size: 16, weight: isActive ? .bold : .semibold))
//                        .foregroundColor(.white)
//                    
//                    Text("\(day.minTemp)°")
//                        .font(.display(size: 16, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.3))
//                }
//                .frame(width: 96, alignment: .trailing)
//            }
//            .padding(16)
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(isActive ? Color.primary.opacity(0.2) : Color.white.opacity(0.05))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 16)
//                        .strokeBorder(isActive ? Color.primary.opacity(0.3) : Color.clear, lineWidth: 1)
//                )
//        )
//    }
//    
//    // MARK: - Map Hint View
//    private var mapHintView: some View {
//        GlassEffectContainer(cornerRadius: 16) {
//            ZStack {
//                // Placeholder for map image
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(height: 128)
//                
//                // Gradient Overlay
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color.backgroundDark.opacity(0.8),
//                        Color.clear
//                    ]),
//                    startPoint: .bottom,
//                    endPoint: .top
//                )
//                
//                // Location Label
//                VStack {
//                    Spacer()
//                    HStack(spacing: 8) {
//                        Image(systemName: "location.fill")
//                            .font(.system(size: 14))
//                            .foregroundColor(.primary)
//                        Text("RADAR VIEW")
//                            .font(.display(size: 12, weight: .bold))
//                            .foregroundColor(.white)
//                            .textCase(.uppercase)
//                            .tracking(2)
//                    }
//                    .padding(.bottom, 16)
//                }
//            }
//        }
//    }
//    
//    // MARK: - Footer View
////    private var footerView: some View {
////        VStack {
////            Rectangle()
////                .fill(Color.white.opacity(0.2))
////                .frame(width: 80, height: 6)
////                .cornerRadius(3)
////        }
////        .padding(.vertical, 24)
////    }
//    
//    // MARK: - Helper Methods
//    private func weatherIconName(for condition: String) -> String {
//        switch condition.lowercased() {
//        case "clear":
//            return "sun.max.fill"
//        case "clouds", "cloudy":
//            return "cloud.fill"
//        case "rain", "rainy":
//            return "cloud.rain.fill"
//        case "snow":
//            return "cloud.snow.fill"
//        default:
//            return "cloud.sun.fill"
//        }
//    }
//    
//    private func weatherIconColor(for condition: String) -> Color {
//        switch condition.lowercased() {
//        case "clear":
//            return .yellow
//        case "clouds", "cloudy":
//            return .blue
//        case "rain", "rainy":
//            return .blue
//        case "snow":
//            return .white
//        default:
//            return .orange
//        }
//    }
//}
//MARK: NEW EXACT REPLICA FILE FROM GEMINI

//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI
import MapKit

//struct HomeView: View {
//    @ObservedObject var viewModel: HomeViewModel
//    var selectedTab: Binding<Int>
//    @State private var showSearch = false
//    @State private var showSettings = false
//    @State private var mapRegion = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    
//    var body: some View {
//        ZStack {
//            // 1. The Global Background
//            AppBackground()
//            
//            VStack(spacing: 0) {
//                
//                // MARK: - Header
//                HStack {
//                    // 1. Search Button (Left)
//                    Button(action: {
//                        showSearch = true
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .font(.system(size: 20))
//                            .foregroundColor(.white)
//                            .frame(width: 50, height: 50)
//                            .glassCircle()
//                    }
//                    
//                    Spacer()
//                    
//                    // 2. Date & Location (Center)
//                    VStack(spacing: 4) {
//                        Text(viewModel.cityName)
//                            .font(.display(size: 17, weight: .bold))
//                            .foregroundColor(.white)
//                        
//                        Text(viewModel.formatDate())
//                            .font(.display(size: 11, weight: .medium))
//                            .foregroundColor(.white.opacity(0.6))
//                            .textCase(.uppercase)
//                            .tracking(1.5)
//                    }
//                    
//                    Spacer()
//                    
//                    // 3. Heart Button (NEW!)
//                    Button(action: {
//                        // Toggle favorite status
//                        viewModel.toggleFavorite()
//                    }) {
//                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
//                            .font(.system(size: 20))
//                            .foregroundColor(viewModel.isFavorite ? .red : .white) // Red if saved
//                            .frame(width: 50, height: 50)
//                            .glassCircle()
//                    }
//                    .padding(.trailing, 8) // Little space between buttons
//                    
//                    // 4. Menu Button (Right)
//                    Button(action: {
//                        showSettings = true
//                    }) {
//                        Image(systemName: "line.3.horizontal")
//                            .font(.system(size: 20))
//                            .foregroundColor(.white)
//                            .frame(width: 50, height: 50)
//                            .glassCircle()
//                    }
//                }
//                .padding(.horizontal, 24)
//                .padding(.top, 10)
//                
//                // MARK: - Scrollable Content
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 24) {
//                        
//                        // 1. Hero Card (The Big Glass One)
//                        GlassEffectContainer(cornerRadius: 40) {
//                            VStack(spacing: 0) {
//                                // Huge Temp
//                                Text("\(viewModel.currentTemp)°")
//                                    .font(.display(size: 110, weight: .thin))
//                                    .foregroundColor(.white)
//                                    .tracking(-2)
//                                    .padding(.vertical, 10)
//                                
//                                // Condition
//                                Text(viewModel.condition)
//                                    .font(.display(size: 24, weight: .light))
//                                    .foregroundColor(.white)
//                                
//                                // H/L
//                                Text(viewModel.highLow)
//                                    .font(.display(size: 16, weight: .medium))
//                                    .foregroundColor(.white.opacity(0.5))
//                                    .padding(.top, 4)
//                                
//                                // Stats Row (Wind/Humidity)
//                                HStack(spacing: 12) {
//                                    statPill(icon: "wind", text: viewModel.windSpeed)
//                                    statPill(icon: "drop.fill", text: viewModel.humidity)
//                                }
//                                .padding(.top, 30)
//                            }
//                            .padding(.vertical, 40)
//                            .padding(.horizontal, 20)
//                            .frame(maxWidth: .infinity)
//                        }
//                        .padding(.top, 20)
//                        
//                        // 2. Forecast Header
//                        HStack {
//                            Text("5-Day Forecast")
//                                .font(.display(size: 18, weight: .bold))
//                                .foregroundColor(.white)
//                            Spacer()
//                            Button("Details") {
//                                selectedTab.wrappedValue = 1
//                            }
//                                .font(.display(size: 14, weight: .regular))
//                                .foregroundColor(Color.primaryBrand)
//                        }
//                        .padding(.horizontal, 8)
//                        
//                        // 3. Forecast List
////                        VStack(spacing: 12) {
////                            ForEach(Array($viewModel.dailyForecast.enumerated()), id: \.element.id) { index, day in
////                                forecastRow(day: day)
////                            }
////                        }
//                        // 3. Forecast List
//                                                VStack(spacing: 12) {
//                                                    // FIX: Iterate directly by value (no $ sign, no enumerated)
//                                                    ForEach(viewModel.dailyForecast) { day in
//                                                        forecastRow(day: day)
//                                                    }
//                                                }
//                        
//                        // 4. Interactive Radar Map
//                        mapView
//                            .padding(.top, 32)
//                        
//                        // Spacing at bottom
//                        Spacer(minLength: 50)
//                    }
//                    .padding(.horizontal, 24)
//                }
//            }
//        }
//        .onAppear {
//            // LocationManager in HomeViewModel will automatically request location on init
//            // and trigger loadWeather when location is available
//        }
//        .sheet(isPresented: $showSearch) {
//            SearchView(isPresented: $showSearch, viewModel: viewModel)
//        }
//        .sheet(isPresented: $showSettings) {
//            SettingsView()
//        }
//    }
//    
//    // MARK: - Sub-Views
//    
//    // The small pills inside the big card
//    func statPill(icon: String, text: String) -> some View {
//        HStack(spacing: 6) {
//            Image(systemName: icon)
//                .font(.system(size: 12))
//                .foregroundColor(.white.opacity(0.7))
//            Text(text)
//                .font(.display(size: 13, weight: .medium))
//                .foregroundColor(.white)
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 10)
//        .background(
//            Capsule()
//                .fill(Color.white.opacity(0.1))
//                .overlay(Capsule().stroke(Color.white.opacity(0.1), lineWidth: 1))
//        )
//    }
//    
//    // The list rows
//    func forecastRow(day: DailyForecastItem) -> some View {
//        Button(action: {
//            selectedTab.wrappedValue = 1
//        }) {
//            GlassEffectContainer(cornerRadius: 20) {
//                HStack {
//                    Text(viewModel.formatDay(day.date))
//                        .font(.display(size: 16, weight: .semibold))
//                        .foregroundColor(.white)
//                        .frame(width: 60, alignment: .leading)
//                    
//                    Spacer()
//                    
//                    // Icon (Use real icons if available, else SF Symbols)
//                    Image(systemName: "cloud.fill")
//                        .renderingMode(.original)
//                        .font(.title3)
//                        .foregroundColor(.white.opacity(0.8))
//                    
//                    Spacer()
//                    
//                    HStack(spacing: 12) {
//                        Text("\(day.maxTemp)°")
//                            .font(.display(size: 16, weight: .bold))
//                            .foregroundColor(.white)
//                        Text("\(day.minTemp)°")
//                            .font(.display(size: 16, weight: .regular))
//                            .foregroundColor(.white.opacity(0.4))
//                    }
//                    .frame(width: 80, alignment: .trailing)
//                }
//                .padding(16)
//            }
//        }
//    }
//    
//    // Interactive Radar Map
//    private var mapView: some View {
//        GlassEffectContainer(cornerRadius: 16) {
//            Map(coordinateRegion: $mapRegion)
//                .frame(height: 200)
//                .cornerRadius(16)
//                .colorScheme(.dark)
//                .onAppear {
//                    updateMapRegion()
//                }
//                .onChange(of: viewModel.currentWeather) { _ in
//                    updateMapRegion()
//                }
//        }
//    }
//    
//    private func updateMapRegion() {
//        if let location = viewModel.currentWeather?.coord {
//            mapRegion = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(
//                    latitude: location.lat,
//                    longitude: location.lon
//                ),
//                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//            )
//        }
//    }
//}

//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  HomeView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var selectedTab: Binding<Int>
    @State private var showSearch = false
    @State private var showSettings = false
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        ZStack {
            // 1. The Global Background
            AppBackground()
            
            VStack(spacing: 0) {
                
                // MARK: - Top Toolbar (Buttons Only)
                HStack {
                    // Search Button (Left)
                    Button(action: {
                        showSearch = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .glassCircle()
                    }
                    
                    Spacer()
                    
                    // Menu Button (Right)
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .glassCircle()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                // MARK: - Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 1. Hero Card (Everything Inside)
                        GlassEffectContainer(cornerRadius: 40) {
                            ZStack(alignment: .topTrailing) {
                                // A. Main Centered Content
                                VStack(spacing: 0) {
                                    
                                    // Location Header Section
                                    VStack(spacing: 4) {
                                        // "MY LOCATION" Badge
                                        if viewModel.isUserLocation {
                                            HStack(spacing: 4) {
                                                Image(systemName: "location.fill")
                                                    .font(.system(size: 10))
                                                Text("MY LOCATION")
                                                    .font(.system(size: 10, weight: .bold))
                                            }
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Capsule().fill(Color.white.opacity(0.2)))
                                            .padding(.bottom, 4)
                                        }
                                        
                                        // City Name
                                        Text(viewModel.cityName)
                                            .font(.display(size: 24, weight: .bold))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                        
                                        // Date & Time
                                        Text(viewModel.formatDate())
                                            .font(.display(size: 13, weight: .medium))
                                            .foregroundColor(.white.opacity(0.7))
                                            .textCase(.uppercase)
                                            .tracking(1)
                                    }
                                    .padding(.top, 20)
                                    
                                    // Huge Temp
                                    Text("\(viewModel.currentTemp)°")
                                        .font(.display(size: 110, weight: .thin))
                                        .foregroundColor(.white)
                                        .tracking(-2)
                                        .padding(.vertical, 10)
                                    
                                    // Condition
                                    Text(viewModel.condition)
                                        .font(.display(size: 24, weight: .light))
                                        .foregroundColor(.white)
                                    
                                    // H/L
                                    Text(viewModel.highLow)
                                        .font(.display(size: 16, weight: .medium))
                                        .foregroundColor(.white.opacity(0.5))
                                        .padding(.top, 4)
                                    
                                    // Stats Row (Wind/Humidity)
                                    HStack(spacing: 12) {
                                        statPill(icon: "wind", text: viewModel.windSpeed)
                                        statPill(icon: "drop.fill", text: viewModel.humidity)
                                    }
                                    .padding(.top, 30)
                                }
                                .padding(.vertical, 40)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity) // Ensure it fills width for centering
                                
                                // B. Heart Button (Top Right Corner)
                                Button(action: {
                                    viewModel.toggleFavorite()
                                }) {
                                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                        .font(.system(size: 24))
                                        .foregroundColor(viewModel.isFavorite ? .red : .white)
                                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                        .padding(24) // Distance from the corner
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        // 2. Forecast Header
                        HStack {
                            Text("5-Day Forecast")
                                .font(.display(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            Spacer()
                            Button("Details") {
                                selectedTab.wrappedValue = 1
                            }
                                .font(.display(size: 14, weight: .regular))
                                .foregroundColor(Color.primaryBrand)
                        }
                        .padding(.horizontal, 8)
                        
                        // 3. Forecast List
                        VStack(spacing: 12) {
                            ForEach(viewModel.dailyForecast) { day in
                                forecastRow(day: day)
                            }
                        }
                        
                        // 4. Interactive Radar Map
                        mapView
                            .padding(.top, 32)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .onAppear {
            // LocationManager updates automatically
        }
        .sheet(isPresented: $showSearch) {
            SearchView(isPresented: $showSearch, viewModel: viewModel)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    // MARK: - Sub-Views
    
    func statPill(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
            Text(text)
                .font(.display(size: 13, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.1))
                .overlay(Capsule().stroke(Color.white.opacity(0.1), lineWidth: 1))
        )
    }
    
    func forecastRow(day: DailyForecastItem) -> some View {
        Button(action: {
            selectedTab.wrappedValue = 1
        }) {
            GlassEffectContainer(cornerRadius: 20) {
                HStack {
                    Text(viewModel.formatDay(day.date))
                        .font(.display(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 60, alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: "cloud.fill")
                        .renderingMode(.original)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Text("\(day.maxTemp)°")
                            .font(.display(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(day.minTemp)°")
                            .font(.display(size: 16, weight: .regular))
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(width: 80, alignment: .trailing)
                }
                .padding(16)
            }
        }
    }
    
    private var mapView: some View {
        GlassEffectContainer(cornerRadius: 16) {
            Map(coordinateRegion: $mapRegion)
                .frame(height: 200)
                .cornerRadius(16)
                .colorScheme(.dark)
                .onAppear {
                    updateMapRegion()
                }
                .onChange(of: viewModel.currentWeather) { _ in
                    updateMapRegion()
                }
        }
    }
    
    private func updateMapRegion() {
        if let location = viewModel.currentWeather?.coord {
            mapRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: location.lat,
                    longitude: location.lon
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(), selectedTab: .constant(0))
}
