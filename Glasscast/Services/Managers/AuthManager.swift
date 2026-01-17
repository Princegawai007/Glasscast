//
//  AuthManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.

import Foundation
import Supabase
import SwiftUI
internal import Combine

@MainActor
class AuthManager: ObservableObject {
    // 1. Singleton: Ensures the whole app talks to the same instance
    static let shared = AuthManager()
    
    // 2. Published Session: UI updates automatically when this changes
    @Published var session: Session?
    
    let client: SupabaseClient
    
    private init() {
        // 3. Initialize Supabase with your Secrets
        self.client = SupabaseClient(
            supabaseURL: Secrets.supabaseURL,
            supabaseKey: Secrets.supabaseAnonKey
        )
        
        // 4. Automatic Listener: Replaces the big 'switch' statement
        Task {
            // This loop runs forever and catches ANY auth change (login, logout, refresh)
            for await state in client.auth.authStateChanges {
                self.session = state.session
            }
        }
    }
    
    // ADD THIS FUNCTION
    func refreshSession() async {
        // Manually check Supabase for the current session
        // This bridges the gap between AuthViewModel and AuthManager
        if let session = try? await client.auth.session {
            self.session = session
        }
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
        // No need to manually set session = nil here.
        // The listener above will catch the 'signedOut' event and do it for us.
    }
    
    func getCurrentSession() async throws -> Session? {
        return try await client.auth.session
    }
}
