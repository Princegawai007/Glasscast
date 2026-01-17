//
//  AuthManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  AuthManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  AuthManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import Foundation
//import Supabase
//import SwiftUI
//internal import Combine
//
//@MainActor
//class AuthManager: ObservableObject {
//    static let shared = AuthManager()
//    
//    // 1. Publish the session so views can update automatically
//    @Published var session: Session?
//    
//    let client: SupabaseClient
//    
//    private init() {
//        // REPLACE THESE WITH YOUR ACTUAL SUPABASE URL AND KEY
//        self.client = SupabaseClient(
//            supabaseURL: URL(string: "https://jioangbzyfjqdohlldwr.supabase.co")!,
//            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imppb2FuZ2J6eWZqcWRvaGxsZHdyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg2MjUzODUsImV4cCI6MjA4NDIwMTM4NX0.euf8ebLtqh99Nvl736Kz-7x7fPY1YHeaEkkQc0D3GoM"
//        )
//
//        
//
//        // 2. Listen for auth changes (Login/Logout) automatically
//        Task {
//            for await state in client.auth.authStateChanges {
//                self.session = state.session
//            }
//        }
//    }
//    
//    func signOut() async throws {
//        try await client.auth.signOut()
//        // The listener above will catch this and set session = nil automatically
//    }
//    
//    func getCurrentSession() async throws -> Session? {
//        return try await client.auth.session
//    }
//}
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
