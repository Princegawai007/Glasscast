//
//  SettingsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  SettingsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//import Supabase
//
//struct SettingsView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var sessionManager: SessionManager
//    
//    var body: some View {
//        ZStack {
//            // 1. Background
//            AppBackground()
//            
//            VStack(spacing: 0) {
//                // 2. Header (Settings + Cancel)
//                HStack {
//                    Text("Settings")
//                        .font(.display(size: 24, weight: .bold))
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text("Cancel")
//                            .font(.display(size: 16, weight: .medium))
//                            .foregroundColor(.white.opacity(0.7))
//                    }
//                }
//                .padding(24)
//                .padding(.top, 10)
//                
//                // 3. Profile Card
//                GlassEffectContainer(cornerRadius: 30) {
//                    VStack(spacing: 20) {
//                        // Avatar Circle
//                        ZStack {
//                            Circle()
//                                .fill(Color.primaryBrand.opacity(0.8))
//                                .frame(width: 80, height: 80)
//                                .overlay(
//                                    Circle()
//                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
//                                )
//                                .shadow(color: Color.primaryBrand.opacity(0.5), radius: 10, x: 0, y: 5)
//                            
//                            // Initials (VG)
//                            Text(getInitials())
//                                .font(.display(size: 28, weight: .bold))
//                                .foregroundColor(.white)
//                        }
//                        .padding(.top, 24)
//                        
//                        // User Details
//                        VStack(spacing: 6) {
//                            Text(getUserName())
//                                .font(.display(size: 20, weight: .bold))
//                                .foregroundColor(.white)
//                            
//                            Text(sessionManager.session?.user.email ?? "")
//                                .font(.display(size: 14, weight: .medium))
//                                .foregroundColor(.white.opacity(0.5))
//                        }
//                        .padding(.bottom, 24)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(24)
//                }
//                .padding(.horizontal, 24)
//                .padding(.top, 20)
//                
//                Spacer()
//                
//                // 4. Sign Out Button
//                Button(action: {
//                    Task {
//                        await sessionManager.signOut()
//                        // Dismiss settings so we don't get stuck if re-login logic is complex
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }) {
//                    Text("Sign Out")
//                        .font(.display(size: 16, weight: .semibold))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 16)
//                        .background(
//                            Capsule()
//                                .fill(Color.red.opacity(0.2))
//                                .overlay(Capsule().stroke(Color.red.opacity(0.5), lineWidth: 1))
//                        )
//                }
//                .padding(24)
//                .padding(.bottom, 20)
//            }
//        }
//    }
//    
//    // MARK: - Helper Functions
//    
//    func getUserName() -> String {
//        guard let metadata = sessionManager.session?.user.userMetadata else {
//            return "Glasscast User"
//        }
//        
//        // Safely unwrap the AnyJSON values
//        let first = extractString(from: metadata["first_name"])
//        let last = extractString(from: metadata["last_name"])
//        
//        if !first.isEmpty || !last.isEmpty {
//            return "\(first) \(last)"
//        }
//        
//        // Fallback if name is missing
//        return "Glasscast User"
//    }
//    
//    func getInitials() -> String {
//        guard let metadata = sessionManager.session?.user.userMetadata else { return "U" }
//        
//        let first = extractString(from: metadata["first_name"])
//        let last = extractString(from: metadata["last_name"])
//        
//        let f = first.prefix(1)
//        let l = last.prefix(1)
//        
//        if f.isEmpty && l.isEmpty {
//            // Use email initial if no name
//            return sessionManager.session?.user.email?.prefix(1).uppercased() ?? "U"
//        }
//        
//        return "\(f)\(l)".uppercased()
//    }
//    
//    // The Magic Fix: Handles Supabase AnyJSON wrapper
//    func extractString(from value: AnyJSON?) -> String {
//        guard let value = value else { return "" }
//        
//        switch value {
//        case .string(let str):
//            return str
//        default:
//            return ""
//        }
//    }
//}
//
//  SettingsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  SettingsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Connects to the same storage as HomeViewModel
    @AppStorage("isCelsius") var isCelsius: Bool = true
    
    @State private var showingSignOutAlert = false
    
    var body: some View {
        ZStack {
            AppBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    Text("Settings")
                        .font(.display(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                }
                .padding(.top, 20)
                
                // Units Section
                GlassEffectContainer(cornerRadius: 16) {
                    VStack(spacing: 0) {
                        Toggle(isOn: $isCelsius) {
                            HStack {
                                Image(systemName: "thermometer.medium")
                                    .foregroundColor(.white)
                                    .frame(width: 24)
                                VStack(alignment: .leading) {
                                    Text("Temperature Unit")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text(isCelsius ? "Celsius (°C) & km/h" : "Fahrenheit (°F) & mph")
                                        .foregroundColor(.white.opacity(0.6))
                                        .font(.caption)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        .padding(16)
                    }
                }
                
                // Sign Out Section
                GlassEffectContainer(cornerRadius: 16) {
                    Button(action: {
                        showingSignOutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                    }
                }
                .alert("Sign Out", isPresented: $showingSignOutAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Sign Out", role: .destructive) {
                        Task {
                            try? await AuthManager.shared.signOut()
                            // Force app restart or navigation change would happen here
                            // depending on your RootView logic
                        }
                    }
                } message: {
                    Text("Are you sure you want to sign out?")
                }
                
                Spacer()
                
                Text("Glasscast v1.0")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(24)
        }
    }
}
