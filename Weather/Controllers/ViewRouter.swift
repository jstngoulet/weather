//
//  ViewRouter.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 This class is in charge of navigating from one view to the other
 */
class ViewRouter: NSObject {
    
    /// Shows the primary controller from the detail
    /// - Note that a navigation controller is required as we are just popping the vew
    /// if we want a different setup, we must include it later
    /// - Parameter controller: The starting controller for the navigation stack
    class func showPrimary(fromController controller: UIViewController) {
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                navigationController.popToRootViewController(animated: false)
            } else {
                fatalError("Navigation Controller is Required in current state")
            }
        }
    }
    
    /// Displays the location permission prompt (full screen) from the provided controller
    /// - Parameter fromController: The starting controller
    class func showLocationPermission(fromController: UIViewController) {
        DispatchQueue.main.async {
            fromController.present(
                CommonViewController(),
                animated: true,
                completion: nil
            )
        }
    }
    
    /// Shows the location details from the provided controller.
    /// - Note: Must be a navigation controller
    /// - Parameters:
    ///   - location: the Location provided from teh API call. Will be used for location lookup
    ///   - fromController: the starting controller in which to navigate from
    class func showDetails(
        forLocation location: WeatherAPIResponse,
        fromController: UIViewController
    ) {
        DispatchQueue.main.async {
            if let navController = fromController.navigationController {
                navController.pushViewController(
                    WeatherDetailsViewController(withWeather: location),
                    animated: true
                )
            } else {
                fromController.present(
                    WeatherDetailsViewController(withWeather: location),
                    animated: true,
                    completion: nil
                )
            }
        }
    }

}
