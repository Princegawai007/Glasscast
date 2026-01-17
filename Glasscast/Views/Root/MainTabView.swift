//  MainTabView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//struct MainTabView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            
//            // MARK: - Layer 1: The Active View
//            Group {
//                switch selectedTab {
//                case 0:
//                    HomeView(viewModel: viewModel, selectedTab: $selectedTab)
//                case 1:
//                    MetricsView(viewModel: viewModel)
//                case 2:
//                    FavoritesView(viewModel: viewModel, selectedTab: $selectedTab)
//                default:
//                    HomeView(viewModel: viewModel, selectedTab: $selectedTab)
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            // MARK: - Layer 2: Floating Glass Tab Bar
//            VStack {
//                Spacer()
//                
//                HStack(spacing: 0) {
//                    // 1. Home Tab
//                    tabButton(icon: "square.grid.2x2.fill", text: "Home", index: 0)
//                    
//                    divider
//                    
//                    // 2. Metrics Tab
//                    tabButton(icon: "chart.bar.fill", text: "Metrics", index: 1)
//                    
//                    divider
//                    
//                    // 3. Favorites Tab
//                    tabButton(icon: "heart.fill", text: "Saved", index: 2)
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 16)
//                .background(
//                    Capsule()
//                        .fill(.ultraThinMaterial)
//                        .environment(\.colorScheme, .dark) // Force dark glass look
//                        .overlay(Capsule().stroke(Color.white.opacity(0.1), lineWidth: 1))
//                        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
//                )
//                .padding(.bottom, 10) // Lift slightly off the bottom edge
//            }
//            .ignoresSafeArea(.keyboard)
//        }
//    }
//    
//    // Helper for Tab Buttons
//    func tabButton(icon: String, text: String, index: Int) -> some View {
//        Button(action: { selectedTab = index }) {
//            VStack(spacing: 4) {
//                Image(systemName: icon)
//                    .font(.system(size: 20))
//                    .foregroundColor(selectedTab == index ? .primaryBrand : .white.opacity(0.4))
//                
//                Text(text)
//                    .font(.caption2)
//                    .fontWeight(selectedTab == index ? .semibold : .regular)
//                    .foregroundColor(selectedTab == index ? .white : .white.opacity(0.4))
//            }
//            .frame(width: 70) // Fixed width for easier tapping
//        }
//    }
//    
//    // Helper for Divider
//    var divider: some View {
//        Rectangle()
//            .fill(Color.white.opacity(0.1))
//            .frame(width: 1, height: 24)
//            .padding(.horizontal, 10)
//    }
//}
//
//
//  MainTabView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
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
