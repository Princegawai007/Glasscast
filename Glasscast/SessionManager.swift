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
            do {
                self.session = try await supabase.auth.session
            } catch {
                self.session = nil
            }
        }
        
        // 2. Listen to auth state changes (FIXED LOOP)
        authStateTask = Task {
            // Unpack the tuple: (event, session)
            for await (event, session) in await supabase.auth.authStateChanges {
                switch event {
                case .signedIn, .tokenRefreshed, .userUpdated, .initialSession:
                    // The session is already provided in the tuple!
                    self.session = session
                    
                case .signedOut:
                    self.session = nil
                    
                case .passwordRecovery:
                    // Handle if needed, or ignore
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    deinit {
        authStateTask?.cancel()
    }
    // Add this inside SessionManager class
        func refreshSession() async {
            try? await supabase.auth.session // This forces a refresh
        }
}
