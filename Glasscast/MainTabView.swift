//
//  MainTabView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//struct MainTabView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    @State private var selectedTab: TabItem = .home
//    
//    enum TabItem {
//        case home
//        case metrics
//    }
//    
//    var body: some View {
//        ZStack {
//            AppBackground()
//            
//            // Content Views
//            Group {
//                if selectedTab == .home {
//                    HomeView(viewModel: viewModel)
//                        .transition(.opacity)
//                } else {
//                    MetricsView(viewModel: viewModel)
//                        .transition(.opacity)
//                }
//            }
//            
//            // Floating Tab Bar
//            VStack {
//                Spacer()
//                
//                GlassEffectContainer(cornerRadius: 30) {
//                    HStack(spacing: 40) {
//                        // Home Tab
//                        Button(action: {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                selectedTab = .home
//                            }
//                        }) {
//                            Image(systemName: "square.grid.2x2")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(selectedTab == .home ? .white : .white.opacity(0.5))
//                        }
//                        
//                        // Metrics Tab
//                        Button(action: {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                selectedTab = .metrics
//                            }
//                        }) {
//                            Image(systemName: "chart.bar")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(selectedTab == .metrics ? .white : .white.opacity(0.5))
//                        }
//                    }
//                    .padding(.horizontal, 32)
//                    .padding(.vertical, 16)
//                }
//                .padding(.horizontal, 24)
//                .padding(.bottom, 40)
//            }
//        }
//    }
//}
//
//#Preview {
//    MainTabView()
//}
//
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
//        ZStack {
//            // Layer 1: The Active View
//            if selectedTab == 0 {
//                HomeView(viewModel: viewModel, selectedTab: $selectedTab)
//            } else {
//                MetricsView(viewModel: viewModel)
//            }
//            
//            // Layer 2: Floating Tab Bar (Bottom Center)
//            VStack {
//                Spacer()
//                
//                HStack(spacing: 40) {
//                    // Home Tab
//                    Button(action: { selectedTab = 0 }) {
//                        VStack(spacing: 4) {
//                            Image(systemName: "square.grid.2x2.fill")
//                                .font(.system(size: 20))
//                                .foregroundColor(selectedTab == 0 ? .primaryBrand : .white.opacity(0.4))
//                            Text("Dashboard")
//                                .font(.caption2)
//                                .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.4))
//                        }
//                    }
//                    
//                    // Divider
//                    Rectangle()
//                        .fill(Color.white.opacity(0.1))
//                        .frame(width: 1, height: 24)
//                    
//                    // Metrics Tab
//                    Button(action: { selectedTab = 1 }) {
//                        VStack(spacing: 4) {
//                            Image(systemName: "chart.bar.fill")
//                                .font(.system(size: 20))
//                                .foregroundColor(selectedTab == 1 ? .primaryBrand : .white.opacity(0.4))
//                            Text("Metrics")
//                                .font(.caption2)
//                                .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.4))
//                        }
//                    }
//                }
//                .padding(.horizontal, 32)
//                .padding(.vertical, 16)
//                .background(
//                    Capsule()
//                        .fill(.ultraThinMaterial)
//                        .environment(\.colorScheme, .dark)
//                        .overlay(Capsule().stroke(Color.white.opacity(0.1), lineWidth: 1))
//                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
//                )
//            }
//        }
//        .ignoresSafeArea(.keyboard)
//    }
//}
//
//  MainTabView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - Layer 1: The Active View
            Group {
                switch selectedTab {
                case 0:
                    HomeView(viewModel: viewModel, selectedTab: $selectedTab)
                case 1:
                    MetricsView(viewModel: viewModel)
                case 2:
                    FavoritesView(viewModel: viewModel, selectedTab: $selectedTab)
                default:
                    HomeView(viewModel: viewModel, selectedTab: $selectedTab)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // MARK: - Layer 2: Floating Glass Tab Bar
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    // 1. Home Tab
                    tabButton(icon: "square.grid.2x2.fill", text: "Home", index: 0)
                    
                    divider
                    
                    // 2. Metrics Tab
                    tabButton(icon: "chart.bar.fill", text: "Metrics", index: 1)
                    
                    divider
                    
                    // 3. Favorites Tab
                    tabButton(icon: "heart.fill", text: "Saved", index: 2)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark) // Force dark glass look
                        .overlay(Capsule().stroke(Color.white.opacity(0.1), lineWidth: 1))
                        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
                )
                .padding(.bottom, 10) // Lift slightly off the bottom edge
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    // Helper for Tab Buttons
    func tabButton(icon: String, text: String, index: Int) -> some View {
        Button(action: { selectedTab = index }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(selectedTab == index ? .primaryBrand : .white.opacity(0.4))
                
                Text(text)
                    .font(.caption2)
                    .fontWeight(selectedTab == index ? .semibold : .regular)
                    .foregroundColor(selectedTab == index ? .white : .white.opacity(0.4))
            }
            .frame(width: 70) // Fixed width for easier tapping
        }
    }
    
    // Helper for Divider
    var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.1))
            .frame(width: 1, height: 24)
            .padding(.horizontal, 10)
    }
}
