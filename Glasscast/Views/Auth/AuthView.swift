//
//  AuthView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

//struct AuthView: View {
//    @StateObject private var viewModel = AuthViewModel()
//    @State private var isSignUp = false
//    
//    var body: some View {
//        ZStack {
//            // Background
//            AppBackground()
//            
//            // Main Content
//            ScrollView {
//                VStack(spacing: 32) {
//                    Spacer(minLength: 80)
//                    
//                    // Glass Card Container
//                    GlassEffectContainer(cornerRadius: 30) {
//                        VStack(spacing: 32) {
//                            // Title
//                            Text("Welcome Back")
//                                .font(.display(size: 42, weight: .thin))
//                                .foregroundColor(.white)
//                                .padding(.top, 40)
//                            
//                            // Email Field
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Email")
//                                    .font(.display(size: 14, weight: .medium))
//                                    .foregroundColor(.white.opacity(0.7))
//                                
//                                TextField("", text: $viewModel.email)
//                                    .textContentType(.emailAddress)
//                                    .keyboardType(.emailAddress)
//                                    .autocapitalization(.none)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 16)
//                                    .background(
//                                        Capsule()
//                                            .fill(.ultraThinMaterial)
//                                            .environment(\.colorScheme, .light)
//                                            .overlay(
//                                                Capsule()
//                                                    .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
//                                            )
//                                    )
//                            }
//                            
//                            // Password Field
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text("Password")
//                                    .font(.display(size: 14, weight: .medium))
//                                    .foregroundColor(.white.opacity(0.7))
//                                
//                                SecureField("", text: $viewModel.password)
//                                    .textContentType(.password)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 20)
//                                    .padding(.vertical, 16)
//                                    .background(
//                                        Capsule()
//                                            .fill(.ultraThinMaterial)
//                                            .environment(\.colorScheme, .light)
//                                            .overlay(
//                                                Capsule()
//                                                    .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
//                                            )
//                                    )
//                            }
//                            
//                            // Error Message
//                            if let errorMessage = viewModel.errorMessage {
//                                Text(errorMessage)
//                                    .font(.display(size: 14, weight: .regular))
//                                    .foregroundColor(.red.opacity(0.9))
//                                    .multilineTextAlignment(.center)
//                                    .padding(.horizontal)
//                            }
//                            
//                            // Sign In Button
//                            Button(action: {
//                                Task {
//                                    if isSignUp {
//                                        await viewModel.signUp()
//                                    } else {
//                                        await viewModel.signIn()
//                                    }
//                                }
//                            }) {
//                                Text(isSignUp ? "Create Account" : "Sign In")
//                                    .font(.display(size: 18, weight: .semibold))
//                                    .foregroundColor(.white)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 16)
//                                    .background(
//                                        Capsule()
//                                            .fill(.ultraThinMaterial)
//                                            .environment(\.colorScheme, .light)
//                                            .overlay(
//                                                Capsule()
//                                                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
//                                            )
//                                    )
//                            }
//                            .disabled(viewModel.isLoading)
//                            .opacity(viewModel.isLoading ? 0.6 : 1.0)
//                            
//                            // Create Account / Sign In Toggle
//                            Button(action: {
//                                withAnimation {
//                                    isSignUp.toggle()
//                                    viewModel.errorMessage = nil
//                                }
//                            }) {
//                                Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Create Account")
//                                    .font(.display(size: 14, weight: .regular))
//                                    .foregroundColor(.white.opacity(0.7))
//                            }
//                            .padding(.bottom, 40)
//                        }
//                        .padding(.horizontal, 32)
//                    }
//                    .padding(.horizontal, 24)
//                    
//                    Spacer(minLength: 80)
//                }
//            }
//        }
//    }
//}
//
//  AuthView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  AuthView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//import Supabase
//
//struct AuthView: View {
//    @StateObject private var viewModel = AuthViewModel()
//    @EnvironmentObject var AuthManager: SessionManager
//    
//    var body: some View {
//        ZStack {
//            // 1. Background
//            AppBackground()
//            
//            // 2. Main Content
//            VStack {
//                Spacer()
//                
//                // 3. Glass Card
//                GlassEffectContainer(cornerRadius: 30) {
//                    VStack(spacing: 24) {
//                        
//                        // Dynamic Title
//                        Text(viewModel.isSignUp ? "Create Account" : "Welcome Back")
//                            .font(.display(size: 32, weight: .thin))
//                            .foregroundColor(.white)
//                            .padding(.bottom, 10)
//                            // Smooth text transition
//                            .transition(.opacity)
//                            .id(viewModel.isSignUp ? "signup" : "login")
//                        
//                        // Error Message
//                        if let error = viewModel.errorMessage {
//                            Text(error)
//                                .font(.caption)
//                                .foregroundColor(.red)
//                                .multilineTextAlignment(.center)
//                        }
//                        
//                        // First Name (Only shown in Sign Up mode)
//                        if viewModel.isSignUp {
//                            glassInput(icon: "person", placeholder: "First Name", text: $viewModel.firstName)
//                                .transition(.move(edge: .top).combined(with: .opacity))
//                        }
//                        
//                        // Last Name (Only shown in Sign Up mode)
//                        if viewModel.isSignUp {
//                            glassInput(icon: "person.fill", placeholder: "Last Name", text: $viewModel.lastName)
//                                .transition(.move(edge: .top).combined(with: .opacity))
//                        }
//                        
//                        // Email
//                        glassInput(icon: "envelope", placeholder: "Email", text: $viewModel.email)
//                        
//                        // Password
//                        glassInput(icon: "lock", placeholder: "Password", text: $viewModel.password, isSecure: true)
//                        
//                        // Confirm Password (Only shown in Sign Up mode)
//                        if viewModel.isSignUp {
//                            glassInput(icon: "lock.shield", placeholder: "Confirm Password", text: $viewModel.confirmPassword, isSecure: true)
//                                .transition(.move(edge: .top).combined(with: .opacity))
//                        }
//                        
//                        // Main Action Button
//                        Button(action: {
//                            Task {
//                                await viewModel.handlePrimaryAction()
//                                await AuthManager.refreshSession()
//                            }
//                        }) {
//                            Text(viewModel.isSignUp ? "Sign Up" : "Sign In")
//                                .font(.display(size: 16, weight: .semibold))
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 16)
//                                .background(
//                                    Capsule()
//                                        .fill(Color.primaryBrand.opacity(0.8))
//                                        .overlay(Capsule().stroke(Color.white.opacity(0.2), lineWidth: 1))
//                                )
//                                .shadow(color: Color.primaryBrand.opacity(0.5), radius: 10, x: 0, y: 5)
//                        }
//                        .disabled(viewModel.isLoading)
//                        
//                        // Toggle Button
//                        Button(action: {
//                            // Animate the layout change
//                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
//                                viewModel.isSignUp.toggle()
//                                viewModel.errorMessage = nil // Clear errors on toggle
//                                // Clear name fields when switching modes
//                                if !viewModel.isSignUp {
//                                    viewModel.firstName = ""
//                                    viewModel.lastName = ""
//                                    viewModel.confirmPassword = ""
//                                }
//                            }
//                        }) {
//                            Text(viewModel.isSignUp ? "Already have an account? Sign In" : "Don't have an account? Create Account")
//                                .font(.display(size: 14, weight: .medium))
//                                .foregroundColor(.white.opacity(0.6))
//                        }
//                    }
//                    .padding(32)
//                }
//                .padding(.horizontal, 24)
//                
//                Spacer()
//            }
//        }
//        .alert("Account Created", isPresented: $viewModel.showSuccessAlert) {
//            Button("OK") {
//                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
//                    viewModel.isSignUp = false
//                }
//            }
//        } message: {
//            Text("Your account has been created successfully. Please sign in.")
//        }
//    }
//    
//    // Helper: Glass Input
//    @ViewBuilder
//    func glassInput(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
//        HStack(spacing: 12) {
//            Image(systemName: icon)
//                .foregroundColor(.white.opacity(0.5))
//                .font(.system(size: 18))
//            
//            Group {
//                if isSecure {
//                    SecureField("", text: text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
//                } else {
//                    TextField("", text: text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
//                }
//            }
//            .foregroundColor(.white)
//            .tint(Color.primaryBrand)
//        }
//        .padding(.horizontal, 20)
//        .padding(.vertical, 16)
//        .background(
//            Capsule()
//                .fill(.ultraThinMaterial)
//                .environment(\.colorScheme, .dark)
//                .overlay(
//                    Capsule()
//                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
//                )
//        )
//    }
//}
//
//#Preview {
//    AuthView()
//        .environmentObject(SessionManager())
//}
//
//  AuthView.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI
import Supabase

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    // FIX 1: Change SessionManager -> AuthManager
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            // 1. Background
            AppBackground()
            
            // 2. Main Content
            VStack {
                Spacer()
                
                // 3. Glass Card
                GlassEffectContainer(cornerRadius: 30) {
                    VStack(spacing: 24) {
                        
                        // Dynamic Title
                        Text(viewModel.isSignUp ? "Create Account" : "Welcome Back")
                            .font(.display(size: 32, weight: .thin))
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                            .transition(.opacity)
                            .id(viewModel.isSignUp ? "signup" : "login")
                        
                        // Error Message
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                        
                        // First Name (Only shown in Sign Up mode)
                        if viewModel.isSignUp {
                            glassInput(icon: "person", placeholder: "First Name", text: $viewModel.firstName)
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        // Last Name (Only shown in Sign Up mode)
                        if viewModel.isSignUp {
                            glassInput(icon: "person.fill", placeholder: "Last Name", text: $viewModel.lastName)
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        // Email
                        glassInput(icon: "envelope", placeholder: "Email", text: $viewModel.email)
                        
                        // Password
                        glassInput(icon: "lock", placeholder: "Password", text: $viewModel.password, isSecure: true)
                        
                        // Confirm Password (Only shown in Sign Up mode)
                        if viewModel.isSignUp {
                            glassInput(icon: "lock.shield", placeholder: "Confirm Password", text: $viewModel.confirmPassword, isSecure: true)
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        // Main Action Button
                        Button(action: {
                            Task {
                                await viewModel.handlePrimaryAction()
                                // FIX 2: Removed 'refreshSession'.
                                // AuthManager detects the login automatically via its listener.
                                await authManager.refreshSession()
                            }
                        }) {
                            Text(viewModel.isSignUp ? "Sign Up" : "Sign In")
                                .font(.display(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    Capsule()
                                        .fill(Color.primaryBrand.opacity(0.8))
                                        .overlay(Capsule().stroke(Color.white.opacity(0.2), lineWidth: 1))
                                )
                                .shadow(color: Color.primaryBrand.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        .disabled(viewModel.isLoading)
                        
                        // Toggle Button
                        Button(action: {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                viewModel.isSignUp.toggle()
                                viewModel.errorMessage = nil
                                if !viewModel.isSignUp {
                                    viewModel.firstName = ""
                                    viewModel.lastName = ""
                                    viewModel.confirmPassword = ""
                                }
                            }
                        }) {
                            Text(viewModel.isSignUp ? "Already have an account? Sign In" : "Don't have an account? Create Account")
                                .font(.display(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    .padding(32)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .alert("Account Created", isPresented: $viewModel.showSuccessAlert) {
            Button("OK") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    viewModel.isSignUp = false
                }
            }
        } message: {
            Text("Your account has been created successfully. Please sign in.")
        }
    }
    
    // Helper: Glass Input
    @ViewBuilder
    func glassInput(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.5))
                .font(.system(size: 18))
            
            Group {
                if isSecure {
                    SecureField("", text: text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                } else {
                    TextField("", text: text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                }
            }
            .foregroundColor(.white)
            .tint(Color.primaryBrand)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

#Preview {
    AuthView()
        // FIX 3: Inject the correct singleton for Previews
        .environmentObject(AuthManager.shared)
}
