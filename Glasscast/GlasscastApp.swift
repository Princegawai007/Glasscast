//
//  GlasscastApp.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//@main
//struct GlasscastApp: App {
//    @StateObject private var sessionManager = SessionManager()
//    
//    var body: some Scene {
//        WindowGroup {
//            Group {
//                if sessionManager.session != nil {
//                    HomeView()
//                } else {
//                    AuthView()
//                }
//            }
//        }
//    }
//}
//
//  GlasscastApp.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

@main
struct GlasscastApp: App {
    // 1. Initialize the SessionManager here
    @StateObject private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            // 2. The Switcher Logic
            Group {
                if sessionManager.session != nil {
                    HomeView()
                        // Transition animation for smooth login
                        .transition(.opacity.animation(.easeInOut))
                } else {
                    AuthView()
                        .transition(.opacity.animation(.easeInOut))
                }
            }
            // 3. CRITICAL FIX: Inject the object here so ALL views get it
            .environmentObject(sessionManager)
        }
    }
}
