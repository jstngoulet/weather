//
//  CommonViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 This class is used for every view controller, to share classes and methods
 */
class CommonViewController: UIViewController {
    
    /// Sets the title on the navigation item
    override var title: String? {
        didSet {
            navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

}

extension CommonViewController {
    
    func customizeNavBar() {
        guard let navigationBar = self.navigationController?.navigationBar
        else { return }
        
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.shadowImage = UIImage()
    }
    
}
