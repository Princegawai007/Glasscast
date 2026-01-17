//
//  Models.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import Foundation
//
//// MARK: - CurrentWeatherResponse
//// Matches OpenWeatherMap API 2.5 Current Weather endpoint
//struct CurrentWeatherResponse: Codable {
//    let coord: Coord
//    let weather: [WeatherCondition]
//    let base: String?
//    let main: MainWeather
//    let visibility: Int?
//    let wind: Wind?
//    let clouds: Clouds?
//    let dt: TimeInterval
//    let sys: Sys
//    let timezone: Int?
//    let id: Int?
//    let name: String?
//    let cod: Int?
//}
//
//// MARK: - Forecast5Response
//// Matches OpenWeatherMap API 2.5 5-day/3-hour Forecast endpoint
//struct Forecast5Response: Codable {
//    let cod: String
//    let message: Double?
//    let cnt: Int
//    let list: [Forecast3Hour]
//    let city: ForecastCity
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lon: Double
//    let lat: Double
//}
//
//// MARK: - WeatherCondition
//struct WeatherCondition: Codable {
//    let id: Int
//    let main: String
//    let description: String
//    let icon: String
//}
//
//// MARK: - MainWeather
//struct MainWeather: Codable {
//    let temp: Double
//    let feelsLike: Double?
//    let tempMin: Double?
//    let tempMax: Double?
//    let pressure: Int?
//    let humidity: Int?
//    let seaLevel: Int?
//    let grndLevel: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case temp, pressure, humidity
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//    }
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int?
//    let gust: Double?
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let type: Int?
//    let id: Int?
//    let country: String?
//    let sunrise: TimeInterval?
//    let sunset: TimeInterval?
//}
//
//// MARK: - Forecast3Hour
//struct Forecast3Hour: Codable {
//    let dt: TimeInterval
//    let main: MainWeather
//    let weather: [WeatherCondition]
//    let clouds: Clouds?
//    let wind: Wind?
//    let visibility: Int?
//    let pop: Double? // Probability of precipitation
//    let rain: Rain3Hour?
//    let snow: Snow3Hour?
//    let dtTxt: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, clouds, wind, visibility, pop, rain, snow
//        case dtTxt = "dt_txt"
//    }
//}
//
//// MARK: - Rain3Hour
//struct Rain3Hour: Codable {
//    let threeH: Double?
//    
//    enum CodingKeys: String, CodingKey {
//        case threeH = "3h"
//    }
//}
//
//// MARK: - Snow3Hour
//struct Snow3Hour: Codable {
//    let threeH: Double?
//    
//    enum CodingKeys: String, CodingKey {
//        case threeH = "3h"
//    }
//}
//
//// MARK: - ForecastCity
//struct ForecastCity: Codable {
//    let id: Int?
//    let name: String?
//    let coord: Coord
//    let country: String?
//    let population: Int?
//    let timezone: Int?
//    let sunrise: TimeInterval?
//    let sunset: TimeInterval?
//}
//
//// MARK: - FavoriteCity
//struct FavoriteCity: Identifiable, Codable {
//    let id: String
//    let userId: String
//    let cityName: String
//    let lat: Double
//    let lon: Double
//    let createdAt: Date
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userId = "user_id"
//        case cityName = "city_name"
//        case lat, lon
//        case createdAt = "created_at"
//    }
//}
//
//// MARK: - City (for search results from Geocoding API)
//struct City: Identifiable, Codable {
//    let id: String
//    let name: String
//    let lat: Double
//    let lon: Double
//    let country: String?
//    let state: String?
//    
//    // Computed property for display
//    var displayName: String {
//        if let state = state, let country = country {
//            return "\(name), \(state), \(country)"
//        } else if let country = country {
//            return "\(name), \(country)"
//        }
//        return name
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case name, lat, lon, country, state
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        lat = try container.decode(Double.self, forKey: .lat)
//        lon = try container.decode(Double.self, forKey: .lon)
//        country = try container.decodeIfPresent(String.self, forKey: .country)
//        state = try container.decodeIfPresent(String.self, forKey: .state)
//        
//        // Generate unique ID from coordinates and name
//        id = "\(name)_\(lat)_\(lon)"
//    }
//}
//
//  Models.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

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

// MARK: - App Specific
//struct DailyForecastItem: Identifiable, Equatable {
//    let id = UUID()
//    let date: Date
//    let minTemp: Int
//    let maxTemp: Int
//    let condition: String
//    let icon: String
//}

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
