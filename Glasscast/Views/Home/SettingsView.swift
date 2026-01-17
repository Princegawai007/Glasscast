//
//  SettingsView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI
internal import Auth

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Connects to the same storage as HomeViewModel
    @AppStorage("isCelsius") var isCelsius: Bool = true
    
    // Profile State
    @State private var userEmail: String = "Loading..."
    @State private var userInitial: String = ""
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
                
                // MARK: - 1. Profile Section (RESTORED)
                GlassEffectContainer(cornerRadius: 16) {
                    HStack(spacing: 16) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            
                            Text(userInitial)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        // User Info
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Signed in as")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(userEmail)
                                .font(.headline)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                }
                
                // MARK: - 2. Units Section
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
                
                // MARK: - 3. Sign Out Section
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
        // Fetch User Data on Load
        .task {
            if let session = try? await AuthManager.shared.getCurrentSession() {
                self.userEmail = session.user.email ?? "Unknown"
                if let firstChar = self.userEmail.first {
                    self.userInitial = String(firstChar).uppercased()
                }
            } else {
                self.userEmail = "Not logged in"
            }
        }
    }
}
