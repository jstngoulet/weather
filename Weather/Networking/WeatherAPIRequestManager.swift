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
    
    /// Gets the mock data response, so we can ignore the API request
    /// - Parameter completion: The weather API response we will use to display the content
    class func getMockDataResponse(
        _ completion: @escaping (Result<WeatherAPIResponse, Error>) -> Void
    ) {
        autoreleasepool {
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let currentData = try? sampleResponse.rawData()
                else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                
                let currentWeather = try jsonDecoder.decode(
                    WeatherAPIResponse.self,
                    from: currentData
                )
                
                completion(.success(currentWeather))
            } catch {
                completion(.failure(NetworkError.otherError(error.localizedDescription)))
            }
        }
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
        
        //  If valid URL, construct the request
        components.queryItems = [
            URLQueryItem(name: "appid", value: Constants.weatherAPIKey)
            , URLQueryItem(name: "lat", value: String(location.latitude))
            , URLQueryItem(name: "lon", value: String(location.longitude))
            , URLQueryItem(name: "exclude", value: "minutely,alerts")
            , URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let urlQuery = components.url
        else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: urlQuery)
        request.httpMethod = "GET"
        
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

private extension WeatherAPIRequestManager {
    
    static var sampleResponse: JSON {
        JSON([
            "lat": 33.44,
            "lon": -94.04,
            "timezone": "America/Chicago",
            "timezone_offset": -18000,
            "current": [
                "dt": 1631857470,
                "sunrise": 1631880069,
                "sunset": 1631924407,
                "temp": 295.58,
                "feels_like": 296.12,
                "pressure": 1014,
                "humidity": 86,
                "dew_point": 293.12,
                "uvi": 0,
                "clouds": 1,
                "visibility": 10000,
                "wind_speed": 0.45,
                "wind_deg": 90,
                "wind_gust": 0.45,
                "weather": [
                    [
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01n"
                    ]
                ]
            ],
            "hourly": [
                [
                    "dt": 1631854800,
                    "temp": 295.58,
                    "feels_like": 296.1,
                    "pressure": 1014,
                    "humidity": 85,
                    "dew_point": 292.93,
                    "uvi": 0,
                    "clouds": 8,
                    "visibility": 10000,
                    "wind_speed": 2.47,
                    "wind_deg": 82,
                    "wind_gust": 4.36,
                    "weather": [
                        [
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01n"
                        ]
                    ],
                    "pop": 0
                ],
                [
                    "dt": 1631858400,
                    "temp": 295.58,
                    "feels_like": 296.12,
                    "pressure": 1014,
                    "humidity": 86,
                    "dew_point": 293.12,
                    "uvi": 0,
                    "clouds": 1,
                    "visibility": 10000,
                    "wind_speed": 2.18,
                    "wind_deg": 83,
                    "wind_gust": 3.24,
                    "weather": [
                        [
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01n"
                        ]
                    ],
                    "pop": 0
                ],
            ],
            "daily": [
                [
                    "dt": 1631901600,
                    "sunrise": 1631880069,
                    "sunset": 1631924407,
                    "moonrise": 1631919120,
                    "moonset": 1631866860,
                    "moon_phase": 0.39,
                    "temp": [
                        "day": 304.89,
                        "min": 292.65,
                        "max": 304.96,
                        "night": 296.17,
                        "eve": 301.28,
                        "morn": 292.65
                    ],
                    "feels_like": [
                        "day": 305.98,
                        "night": 296.85,
                        "eve": 302.91,
                        "morn": 293.16
                    ],
                    "pressure": 1014,
                    "humidity": 45,
                    "dew_point": 291.76,
                    "wind_speed": 4.73,
                    "wind_deg": 61,
                    "wind_gust": 6.58,
                    "weather": [
                        [
                            "id": 801,
                            "main": "Clouds",
                            "description": "few clouds",
                            "icon": "02d"
                        ]
                    ],
                    "clouds": 24,
                    "pop": 0.48,
                    "uvi": 7.79
                ],
                [
                    "dt": 1631988000,
                    "sunrise": 1631966509,
                    "sunset": 1632010723,
                    "moonrise": 1632007740,
                    "moonset": 1631957160,
                    "moon_phase": 0.42,
                    "temp": [
                        "day": 301.59,
                        "min": 293.96,
                        "max": 302.63,
                        "night": 296.09,
                        "eve": 299.02,
                        "morn": 293.96
                    ],
                    "feels_like": [
                        "day": 304.54,
                        "night": 296.84,
                        "eve": 299.78,
                        "morn": 294.68
                    ],
                    "pressure": 1016,
                    "humidity": 69,
                    "dew_point": 295.34,
                    "wind_speed": 3.11,
                    "wind_deg": 55,
                    "wind_gust": 5.45,
                    "weather": [
                        [
                            "id": 501,
                            "main": "Rain",
                            "description": "moderate rain",
                            "icon": "10d"
                        ]
                    ],
                    "clouds": 75,
                    "pop": 1,
                    "rain": 7.58,
                    "uvi": 5.47
                ],
        ]
        ])
        
    }
    
}
