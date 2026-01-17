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

import Foundation
import Supabase
internal import Combine

@MainActor
class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: Secrets.supabaseURL,
            supabaseKey: Secrets.supabaseAnonKey
        )
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    // Helper to get current session if needed
    func getCurrentSession() async throws -> Session? {
        return try await client.auth.session
    }
}
