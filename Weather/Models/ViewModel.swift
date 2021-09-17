//
//  ViewModel.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit
import MaterialComponents.MDCSnackbarMessage

/**
 The parent class for all view models
 */
class ViewModel: NSObject {
    
    /// The current controller associated
    weak var viewController: UIViewController?
    
    deinit {
        viewController = nil
    }
    
}

extension ViewModel {
    
    /// Shows a snack bar mesage from any view model
    /// - Parameter message: The mesage to show to the user
    func show(message: String) {
        MDCSnackbarManager.default.show(
            MDCSnackbarMessage(
                text: message
            )
        )
    }
    
}
