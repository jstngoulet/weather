//
//  OneAPIDataModel.swift
//  Weather
//
//  Created by Justin Goulet on 9/16/21.
//

import Foundation

struct WeatherAPIResponse: Codable {
    
    var lat: Double
    var lng: Double
    var timezone: String
    var timezoneOffset: Int
    var current: CurrentConditions
    
    struct CurrentConditions: Codable {
        var dt: Int
        var sunrise: Int
        var sunset: Int
        var temp: Double
        var feelsLike: Double
        var pressure: Int
        var dewPoint: Double
        var uvi: Double
        var clouds: Double
        var visibility: Int
        var windSpeed: Int
        var windDeg: Int
        var weather: Weather
        
        struct Weather: Codable {
            var id: String
            var main: String
            var description: String
            var icon: String
        }
        
        var rain: Rain
        
        struct Rain: Codable {
            var currentHour: String
            
            enum CodingKeys: String, CodingKey {
                case currentHour = "1h"
            }
        }
        
        var hourly: [Weather]
        
        var daily: DailyWeather
        
        struct DailyWeather: Codable {
            var dt: Int
            var sunrise: Int
            var sunset: Int
            var moonrise: Int
            var moonset: Int
            var moonPhase: Double
            var temp: Temp
            
            struct Temp: Codable {
                var day: Double
                var min: Double
                var max: Double
                var night: Double
                var eve: Double
                var morn: Double
            }
            
            var feelsLike: FeelsLike
            
            struct FeelsLike: Codable {
                var day: Double
                var night: Double
                var eve: Double
                var moun: Double
            }
            
            var pressure: Int
            var humidty: Int
            var dewPoint: Double
            var windSpeed: Double
            var windDeg: Int
            var weather: [Weather]
            var clouds: Int
            var pop: Double
            var rain: Double
            var uvi: Double
        }
    }
    
    /// The current string for the provided icon
    var iconURLString: String
    { "http://openweathermap.org/img/wn/\(current.weather.icon)@2x.png"
    }
    
}
