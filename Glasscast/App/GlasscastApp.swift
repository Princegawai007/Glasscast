//
//  GlasscastApp.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//


import SwiftUI

@main
struct GlasscastApp: App {
    // FIX 1: Use AuthManager.shared (Singleton) so it matches SettingsView
    @StateObject private var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            // FIX 2: Check authManager.session
            Group {
                if authManager.session != nil {
                    MainTabView()
                        .transition(.opacity.animation(.easeInOut))
                } else {
                    AuthView() // Make sure your Login view is named AuthView or LoginView
                        .transition(.opacity.animation(.easeInOut))
                }
            }
            // FIX 3: Inject it as an EnvironmentObject if other views need it
            .environmentObject(authManager)
        }
    }
}
