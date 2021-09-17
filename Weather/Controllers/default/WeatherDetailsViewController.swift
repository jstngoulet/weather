//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/17/21.
//

import UIKit

/**
    Shows the detail of the controller
 */
class WeatherDetailsViewController: CommonViewController {
    
    /// The text field housing the description
    private lazy var descriptionTextField: UITextView = {
       UITextView()
    }()
    
    /// The view modeel for the contorller. Should set up all text and actions on the page
    /// @TODO: Curently just a defailt view model, need to build out
    private lazy var viewModel: ViewModel = {
       let model = ViewModel()
        model.viewController = self
        return model
    }()
    
    /// Init the screen with a preloaded response, send to view model
    /// - Parameter weather: The current rweather to show on the page
    init(withWeather weather: WeatherAPIResponse) {
        super.init(nibName: nil, bundle: nil)
        descriptionTextField.text = "\(weather)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Lifecycle funcction for whenthe view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .red
        build()
    }

}

//  MARK: - Build the view
private extension WeatherDetailsViewController {
    
    func build() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        view.addChildren([
            descriptionTextField
        ])
    }
    
    func setConstraints() {
        descriptionTextField.autoPinEdgesToSuperviewSafeArea()
    }
    
}
