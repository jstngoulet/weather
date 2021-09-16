//
//  RootWeatherViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 The primary controller on the view. Houses the summary
 */
class RootWeatherViewController: CommonViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
//        img.image = viewModel.backgroundImage //  Set the background image based on time of day
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//  MARK: - Build and Construct the view
private extension RootWeatherViewController {
    
    /// Wrapper function to build the view
    func build() {
        addSubviews()
        setContraints()
    }
    
    /// Adds the children views to the parent
    func addSubviews() {
        view.addChildren([
        
        ])
    }
    
    /// Sets the constraints on the children views
    func setContraints() {
        
    }
    
}
