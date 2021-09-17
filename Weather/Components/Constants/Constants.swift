//
//  Constants.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit
import Keys

/**
 Global Constants currently available
 */

class Constants: NSObject {

    static var offset: CGFloat = 15
    
    /// Init once, instead of every time
    private static var currentKeys = WeatherKeys()
    
    /// Get the weather api key
    static var weatherAPIKey: String
    { currentKeys.openWeatherAPIKey }
    
}
