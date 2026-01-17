//
//  WeatherService.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import Foundation

// MARK: - WeatherServiceError
enum WeatherServiceError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case apiError(String)
}

// MARK: - OpenWeatherAPIError
struct OpenWeatherAPIError: Codable {
    let cod: String?
    let message: String
}

// MARK: - WeatherService
class WeatherService {
    static let shared = WeatherService()
    
    private let session: URLSession
    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    private init(session: URLSession = .shared) {
        self.session = session
        self.apiKey = Secrets.openWeatherAPIKey
    }
    
    /// Fetches current weather data for the given latitude and longitude using OpenWeatherMap API 2.5
    /// - Parameters:
    ///   - lat: Latitude in decimal degrees
    ///   - lon: Longitude in decimal degrees
    ///   - units: Temperature units (default: "metric" for Celsius, use "imperial" for Fahrenheit)
    /// - Returns: A CurrentWeatherResponse instance containing current weather data
    /// - Throws: WeatherServiceError for various failure scenarios
    func fetchWeather(lat: Double, lon: Double, units: String = "metric") async throws -> CurrentWeatherResponse {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units)
        ]
        
        guard let url = components.url else {
            throw WeatherServiceError.invalidURL
        }
        
        return try await performRequest(url: url, responseType: CurrentWeatherResponse.self)
    }
    
    /// Fetches 5-day/3-hour forecast data for the given latitude and longitude using OpenWeatherMap API 2.5
    /// - Parameters:
    ///   - lat: Latitude in decimal degrees
    ///   - lon: Longitude in decimal degrees
    ///   - units: Temperature units (default: "metric" for Celsius, use "imperial" for Fahrenheit)
    /// - Returns: A Forecast5Response instance containing forecast data
    /// - Throws: WeatherServiceError for various failure scenarios
    func fetchForecast(lat: Double, lon: Double, units: String = "metric") async throws -> Forecast5Response {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: units)
        ]
        
        guard let url = components.url else {
            throw WeatherServiceError.invalidURL
        }
        
        return try await performRequest(url: url, responseType: Forecast5Response.self)
    }
    
    // MARK: - Private Helpers
    
    /// Generic method to perform network requests and decode responses
    private func performRequest<T: Codable>(url: URL, responseType: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            
            // Check HTTP status code
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherServiceError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                // Try to parse error message from API
                if let apiError = try? JSONDecoder().decode(OpenWeatherAPIError.self, from: data) {
                    throw WeatherServiceError.apiError(apiError.message)
                }
                throw WeatherServiceError.invalidResponse
            }
            
            // Decode JSON response
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            
            do {
                let decodedResponse = try decoder.decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw WeatherServiceError.decodingFailed(error)
            }
        } catch let error as WeatherServiceError {
            throw error
        } catch {
            throw WeatherServiceError.requestFailed(error)
        }
    }
}
