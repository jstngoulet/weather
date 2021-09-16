//
//  ViewModel.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

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
