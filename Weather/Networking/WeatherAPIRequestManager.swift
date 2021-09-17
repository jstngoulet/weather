//
//  WeatherAPIRequestManager.swift
//  Weather
//
//  Created by Justin Goulet on 9/16/21.
//

import UIKit
import SwiftyJSON
import CoreLocation

/**
 maanges the
 */
class WeatherAPIRequestManager: NSObject {
    
    enum NetworkError: LocalizedError {
        case noNetwork
        case decodingError
        case noData
        case invalidURL
        case otherError(String)
    }
    
    class func getLocationMockReponse(
        forLocation location: CLLocationCoordinate2D
        , completion: @escaping (Result<WeatherAPIResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall")
        , var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        //  If there is stored data, return that. Else, fetch and store it
        
        //  If valid URL, construct the request
        components.queryItems = [
            URLQueryItem(name: "appid", value: Constants.weatherAPIKey)
            , URLQueryItem(name: "lat", value: String(location.latitude))
            , URLQueryItem(name: "lon", value: String(location.longitude))
            , URLQueryItem(name: "exclude", value: "minutely,alerts")
            , URLQueryItem(name: "units", value: "imperial")    //  Add user defaults
        ]
        
        guard let urlQuery = components.url
        else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: urlQuery)
        request.httpMethod = "GET"
        
        //  Start the request to the server
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let errorFound = error {
                completion(.failure(NetworkError.otherError(errorFound.localizedDescription)))
            } else if let dataFound = data
            , let responseFound = response as? HTTPURLResponse {
                // Decode the result
                do {
                    if responseFound.statusCode == 200 {
                        let weatherResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: dataFound)
                        completion(.success(weatherResponse))
                    } else {
                        completion(
                            .failure(
                                NetworkError.otherError("Response wasn't 200. It was: " + "\n\(responseFound.statusCode)")
                            )
                        )
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.noData))
            }
        }.resume()
    }
    
}

extension WeatherAPIRequestManager {
    
    /// Gets the stored location data
    /// - Note: Uses NSUserDefaults. Should be coreData
    /// - Parameter location: The location to store from. could be zip after geocode
    /// - Parameter expirationMinutes: Number of minutes until refresh required. default 15
    /// - Returns: The weather api response, if still valid
    func getWeatherData(
        forLocation location: CLLocation
        , expirationMinutes: Int = 15
    ) -> WeatherAPIResponse? {
        let defaults = UserDefaults.standard
        
        //  Load the current data store
        if let stored = defaults.object(forKey: "latest_data") as? StorableWeatherResponse {
            //  Determine if the same coord
            //  TODO: need to finish
        }
        
        return nil
    }
    
}
