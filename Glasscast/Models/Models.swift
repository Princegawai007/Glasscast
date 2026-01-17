//
//  Models.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation

// MARK: - Current Weather
struct CurrentWeatherResponse: Codable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    let dt: TimeInterval
    let sys: Sys?
    let visibility: Int?
    
}

struct Coord: Codable, Equatable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable, Equatable {
    let temp: Double
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    //    let feels_like: Double // <--- ADD THIS LINE
    
    // The Bridge: Maps API "temp_min" to Swift "tempMin"
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        //        case feels_like
    }
}

struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int?
}

struct Sys: Codable, Equatable {
    let country: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
}

// MARK: - Forecast (Fixes "Forecast5Response" error)
struct Forecast5Response: Codable, Equatable {
    let list: [Forecast3Hour]
}

struct Forecast3Hour: Codable, Equatable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - Search & City (Fixes "City" error)
struct City: Identifiable, Codable, Equatable {
    var id: String { "\(lat)-\(lon)" }
    let name: String
    let lat: Double
    let lon: Double
    let country: String?
    let state: String?
}

// Alias for Geocoding API response
typealias GeocodingResponse = City

// MARK: - UV Response
struct UVResponse: Codable {
    let value: Double
}
// MARK: - Favorites Model
struct SavedCity: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let lat: Double
    let lon: Double
    let country: String?
    // We make these optional so decoding doesn't fail if DB returns extra fields
    let user_id: UUID?
    let created_at: String?
}
