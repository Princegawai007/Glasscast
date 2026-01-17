//
//  AuthViewModel.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import Foundation
//import SwiftUI
//import Supabase
//internal import Combine
//
//@MainActor
//class AuthViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    private let supabase: SupabaseClient
//    
//    init() {
//        self.supabase = SupabaseClient(
//            supabaseURL: Secrets.supabaseURL,
//            supabaseKey: Secrets.supabaseAnonKey
//        )
//    }
//    
//    func signIn() async {
//        isLoading = true
//        errorMessage = nil
//        
//        guard !email.isEmpty, !password.isEmpty else {
//            errorMessage = "Please enter both email and password"
//            isLoading = false
//            return
//        }
//        
//        do {
//            _ = try await supabase.auth.signIn(
//                email: email,
//                password: password
//            )
//            // Success - session will be updated via SessionManager
//        } catch {
//            errorMessage = error.localizedDescription
//            print("Sign in error: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//    
//    func signUp() async {
//        isLoading = true
//        errorMessage = nil
//        
//        guard !email.isEmpty, !password.isEmpty else {
//            errorMessage = "Please enter both email and password"
//            isLoading = false
//            return
//        }
//        
//        guard password.count >= 6 else {
//            errorMessage = "Password must be at least 6 characters"
//            isLoading = false
//            return
//        }
//        
//        do {
//            _ = try await supabase.auth.signUp(
//                email: email,
//                password: password
//            )
//            // Success - session will be updated via SessionManager
//        } catch {
//            errorMessage = error.localizedDescription
//            print("Sign up error: \(error.localizedDescription)")
//        }
//        
//        isLoading = false
//    }
//}
//
//  AuthViewModel.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
import Supabase
internal import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = "" // New Field
    @Published var isSignUp = false     // The Toggle State
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase: SupabaseClient
    
    init() {
        self.supabase = SupabaseClient(
            supabaseURL: Secrets.supabaseURL,
            supabaseKey: Secrets.supabaseAnonKey
        )
    }
    
    // The main action button calls this
    func handlePrimaryAction() async {
        if isSignUp {
            await signUp()
        } else {
            await signIn()
        }
    }
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await supabase.auth.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signUp() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        // Validate Passwords Match
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await supabase.auth.signUp(email: email, password: password)
            // If auto-confirm is off, you might need to tell user to check email here
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
