//
//  FavoritesService.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  FavoritesService.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation
import Supabase

class FavoritesService {
    static let shared = FavoritesService()
    private let client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: Secrets.supabaseURL,
            supabaseKey: Secrets.supabaseAnonKey
        )
    }
    
    // 1. Fetch all cities for the logged-in user
    func fetchFavorites() async throws -> [SavedCity] {
        let cities: [SavedCity] = try await client
            .from("saved_cities")
            .select()
            .order("created_at", ascending: false)
            .execute()
            .value
        
        return cities
    }
    
    // 2. Add a new city
    func addFavorite(name: String, lat: Double, lon: Double, country: String) async throws {
        // We need the current user's ID to save it to the database
        let user = try await client.auth.user()
        
        let newCity = SavedCity(
            id: UUID(), // Generate a temporary ID (DB will handle its own if needed, but UUID is fine)
            name: name,
            lat: lat,
            lon: lon,
            country: country,
            user_id: user.id,
            created_at: nil
        )
        
        try await client
            .from("saved_cities")
            .insert(newCity)
            .execute()
    }
    
    // 3. Delete a city by ID
    func removeFavorite(id: UUID) async throws {
        try await client
            .from("saved_cities")
            .delete()
            .eq("id", value: id)
            .execute()
    }
}
