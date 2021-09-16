//
//  CommonViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

class CommonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension CommonViewController {
    
    func customizeNavBar() {
        guard let navigationBar = self.navigationController?.navigationBar
        else { return }
        
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
}
