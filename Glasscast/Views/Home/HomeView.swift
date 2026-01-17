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
            // 1. Global Background
            AppBackground()
            
            VStack(spacing: 0) {
                // MARK: - Top Toolbar
                HStack {
                    // Search Button (Glass Circle)
                    Button(action: { showSearch = true }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .glassCircle() // Uses new liquid style
                    }
                    
                    Spacer()
                    
                    // Menu Button (Glass Circle)
                    Button(action: { showSettings = true }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .glassCircle() // Uses new liquid style
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                // MARK: - Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Error Banner
                        if viewModel.isOffline {
                            HStack {
                                Image(systemName: "wifi.slash")
                                Text("No Internet Connection")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Capsule().fill(Color.red.opacity(0.6)))
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        // 1. Hero Card (Liquid Glass)
                        LiquidGlassContainer(cornerRadius: 40) {
                            ZStack(alignment: .topTrailing) {
                                VStack(spacing: 0) {
                                    
                                    // Location Header
                                    VStack(spacing: 4) {
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
                                        
                                        Text(viewModel.cityName)
                                            .font(.display(size: 24, weight: .bold))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                        
                                        Text(viewModel.formatDate())
                                            .font(.display(size: 13, weight: .medium))
                                            .foregroundColor(.white.opacity(0.7))
                                            .textCase(.uppercase)
                                            .tracking(1)
                                    }
                                    .padding(.top, 20)
                                    
                                    // Temp
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
                                    
                                    // Stats Row
                                    HStack(spacing: 12) {
                                        statPill(icon: "wind", text: viewModel.windSpeed)
                                        statPill(icon: "drop.fill", text: viewModel.humidity)
                                    }
                                    .padding(.top, 30)
                                }
                                .padding(.vertical, 40)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                                
                                // Heart Button (Inside Glass)
                                Button(action: { viewModel.toggleFavorite() }) {
                                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                        .font(.system(size: 24))
                                        .foregroundColor(viewModel.isFavorite ? .red : .white)
                                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                        .padding(24)
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
                            Button("Details") { selectedTab.wrappedValue = 1 }
                                .font(.display(size: 14, weight: .regular))
                                .foregroundColor(Color.primaryBrand)
                        }
                        .padding(.horizontal, 8)
                        
                        // 3. Forecast List
                        VStack(spacing: 12) {
                            if viewModel.dailyForecast.isEmpty {
                                Text("Forecast Unavailable")
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding()
                            } else {
                                ForEach(viewModel.dailyForecast) { day in
                                    forecastRow(day: day)
                                }
                            }
                        }
                        
                        // 4. Map
                        mapView.padding(.top, 32)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 24)
                }
                .refreshable {
                    await viewModel.refreshWeather()
                }
            }
        }
        // <--- ADD THESE MODIFIERS HERE
        // 1. Light bump when opening Search
        .sensoryFeedback(.impact(weight: .light), trigger: showSearch)
        
        // 2. Light bump when opening Settings
        .sensoryFeedback(.impact(weight: .light), trigger: showSettings)
        
        // 3. Solid bump when Favoriting (Heart button)
        .sensoryFeedback(.impact(weight: .medium), trigger: viewModel.isFavorite)
        
        // 4. Success vibration when refresh finishes
        .sensoryFeedback(.success, trigger: viewModel.isLoading) { oldValue, newValue in
            // Only trigger success when loading changes from true -> false
            return oldValue == true && newValue == false
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
        Button(action: { selectedTab.wrappedValue = 1 }) {
            // Replaced GlassEffectContainer with LiquidGlassContainer
            LiquidGlassContainer(cornerRadius: 20) {
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
        LiquidGlassContainer(cornerRadius: 16) {
            Map(coordinateRegion: $mapRegion)
                .frame(height: 200)
                .cornerRadius(16)
                .colorScheme(.dark)
                .onAppear { updateMapRegion() }
                .onChange(of: viewModel.currentWeather) { _ in updateMapRegion() }
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
