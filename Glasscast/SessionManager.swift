//
//  SessionManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import Foundation
//import SwiftUI
//import Supabase
//internal import Combine
//
//
//@MainActor
//class SessionManager: ObservableObject {
//    @Published var session: Session?
//    
//    private let supabase: SupabaseClient
//    private var authStateTask: Task<Void, Never>?
//    
//    init() {
//        self.supabase = SupabaseClient(
//            supabaseURL: Secrets.supabaseURL,
//            supabaseKey: Secrets.supabaseAnonKey
//        )
//        
//        // Get initial session
//        Task {
//            await getCurrentSession()
//        }
//        
//        // Listen to auth state changes
//        authStateTask = Task {
//            for await state in await supabase.auth.authStateChanges {
//                switch state {
//                case .initialSession, .signedIn, .tokenRefreshed:
//                    if let currentSession = try? await supabase.auth.session {
//                        self.session = currentSession
//                    }
//                case .signedOut:
//                    self.session = nil
//                case .userUpdated:
//                    if let currentSession = try? await supabase.auth.session {
//                        self.session = currentSession
//                    }
//                }
//            }
//        }
//    }
//    
//    private func getCurrentSession() async {
//        do {
//            self.session = try await supabase.auth.session
//        } catch {
//            self.session = nil
//        }
//    }
//    
//    deinit {
//        authStateTask?.cancel()
//    }
//}
//
//  SessionManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  SessionManager.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
import SwiftUI
import Supabase
internal import Combine

@MainActor
class SessionManager: ObservableObject {
    @Published var session: Session?
    
    private let supabase: SupabaseClient
    private var authStateTask: Task<Void, Never>?
    
    init() {
        self.supabase = SupabaseClient(
            supabaseURL: Secrets.supabaseURL,
            supabaseKey: Secrets.supabaseAnonKey
        )
        
        // 1. Get initial session immediately
        Task {
            await refreshSession()
        }
        
        // 2. Listen to auth state changes
        authStateTask = Task {
            for await (event, session) in await supabase.auth.authStateChanges {
                switch event {
                case .signedIn, .tokenRefreshed, .userUpdated, .initialSession:
                    self.session = session
                case .signedOut:
                    self.session = nil
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - CRITICAL FIX
    // This function must explicitly assign the session to self.session
    func refreshSession() async {
        do {
            self.session = try await supabase.auth.session
        } catch {
            // If fetching fails (e.g., no internet or invalid token), likely signed out
            print("Session refresh failed: \(error)")
        }
    }
    
    deinit {
        authStateTask?.cancel()
    }
}
