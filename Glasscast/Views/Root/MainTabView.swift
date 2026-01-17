//  MainTabView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct MainTabView: View {
    // We initialize the shared ViewModel here
    @StateObject private var viewModel = HomeViewModel()
    
    // Controls which tab is active (0 = Home, 1 = Metrics, 2 = Favorites)
    @State private var selectedTab = 0
    
    var body: some View {
        // Standard iOS Tab View
        TabView(selection: $selectedTab) {
            
            // MARK: - Tab 1: Home
            HomeView(viewModel: viewModel, selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "square.grid.2x2.fill")
                }
                .tag(0)
            
            // MARK: - Tab 2: Metrics
            MetricsView(viewModel: viewModel)
                .tabItem {
                    Label("Metrics", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            // MARK: - Tab 3: Saved Cities
            FavoritesView(viewModel: viewModel, selectedTab: $selectedTab)
                .tabItem {
                    Label("Saved", systemImage: "heart.fill")
                }
                .tag(2)
        }
        .sensoryFeedback(.selection, trigger: selectedTab)
        // Sets the color of the active tab icon (White fits your Dark theme best)
        .accentColor(.white)
        // Ensures the tab bar is visible on top of your dark background
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            appearance.backgroundColor = UIColor(Color.black.opacity(0.2))
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
