//
//  SearchView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct SearchView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var searchText = ""
    @State private var searchResults: [City] = []
    @State private var isSearching = false
    
    var body: some View {
        ZStack {
            // Background
            AppBackground()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.5))
                        
                        TextField("Search city...", text: $searchText)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .onChange(of: searchText) { newValue in
                                performSearch(query: newValue)
                            }
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    .padding(12)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    
                    // Cancel Button
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // Content List
                ScrollView {
                    VStack(spacing: 12) {
                        if searchText.isEmpty {
                            
                            // MARK: - 1. Current Location Button (NEW)
                            Button(action: {
                                viewModel.requestUserLocation()
                                isPresented = false
                            }) {
                                GlassEffectContainer(cornerRadius: 16) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(Color.blue.opacity(0.2))
                                                .frame(width: 40, height: 40)
                                            
                                            Image(systemName: "location.fill")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 18))
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Current Location")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("GPS Positioning")
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.6))
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(12)
                                }
                            }
                            .padding(.top, 10)
                            
                        } else {
                            // MODE 2: Show Search Results
                            if isSearching {
                                ProgressView()
                                    .tint(.white)
                                    .padding(.top, 40)
                            } else {
                                ForEach(searchResults) { city in
                                    searchResultRow(city)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: - Row Views
    
    // 1. Row for Search Results
    func searchResultRow(_ city: City) -> some View {
        Button(action: {
            // HAPTIC HERE
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            Task {
                await viewModel.previewCity(city)
                isPresented = false
            }
        }) {
            GlassEffectContainer(cornerRadius: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(city.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(city.state ?? ""), \(city.country ?? "")")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Spacer()
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(16)
            }
        }
    }
    
    // 2. Row for Saved Cities (Favorites)
    func savedCityRow(_ city: SavedCity) -> some View {
        Button(action: {
            Task {
                // Convert SavedCity to standard City for preview
                let cityObj = City(name: city.name, lat: city.lat, lon: city.lon, country: city.country ?? "", state: nil)
                await viewModel.previewCity(cityObj)
                isPresented = false
            }
        }) {
            GlassEffectContainer(cornerRadius: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(city.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(city.country ?? "")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Spacer()
                    Image(systemName: "heart.fill") // Show heart to indicate it's saved
                        .foregroundColor(.red.opacity(0.8))
                }
                .padding(16)
            }
        }
    }
    
    // MARK: - Logic
    func performSearch(query: String) {
        guard query.count > 2 else {
            searchResults = []
            return
        }
        
        isSearching = true
        
        Task {
            // Add a small delay to avoid spamming API while typing
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            if let results = try? await WeatherService.shared.searchCity(query: query) {
                await MainActor.run {
                    self.searchResults = results
                    self.isSearching = false
                }
            }
        }
    }
}
