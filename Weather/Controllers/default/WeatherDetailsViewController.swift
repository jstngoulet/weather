//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/17/21.
//

import UIKit

/**
 
 */
class WeatherDetailsViewController: CommonViewController {
    
    private lazy var descriptionTextField: UITextView = {
       UITextView()
    }()
    
    private lazy var viewModel: ViewModel = {
       let model = ViewModel()
        model.viewController = self
        return model
    }()
    
    init(withWeather weather: WeatherAPIResponse) {
        super.init(nibName: nil, bundle: nil)
        descriptionTextField.text = "\(weather)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        view.backgroundColor = .red
        build()
    }

}

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
