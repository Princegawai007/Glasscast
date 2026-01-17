//
//  FavoritesView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var selectedTab: Int // We need this to switch back to Home
    
    var body: some View {
        ZStack {
            // Background
            AppBackground()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("My Cities")
                        .font(.display(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(24)
                .padding(.top, 10)
                
                // Content
                if viewModel.savedCities.isEmpty {
                    // MARK: - Empty State
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image(systemName: "heart.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.3))
                        
                        Text("No Favorites Yet")
                            .font(.display(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Search for a city and tap the heart icon to save it here.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.6))
                            .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                } else {
                    // MARK: - Cities List
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.savedCities) { city in
                                savedCityCard(city)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 100) // Space for Tab Bar
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
    
    // Custom Card for Saved Cities
    func savedCityCard(_ city: SavedCity) -> some View {
        Button(action: {
            Task {
                // 1. Load the selected city
                let cityObj = City(name: city.name, lat: city.lat, lon: city.lon, country: city.country ?? "", state: nil)
                await viewModel.previewCity(cityObj)
                
                // 2. Switch back to Home Tab to see it
                withAnimation {
                    selectedTab = 0
                }
            }
        }) {
            GlassEffectContainer(cornerRadius: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(city.name)
                            .font(.display(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(city.country ?? "Unknown")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    Spacer()
                    
                    // Arrow Icon
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(20)
            }
        }
    }
}
