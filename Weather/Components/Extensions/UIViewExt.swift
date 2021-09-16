//
//  UIViewExt.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import Foundation
import UIKit

/**
 Extends UIView for helpful functions
 */
extension UIView {
    
    /// Adds an array of subviews to the parnet
    /// - Parameter views: The list of subviews to add to the parent
    func addChildren(_ views: [UIView]) {
        views.forEach({ addSubview($0 )})
    }
    
    func setGradient(colors: [UIColor]) {
        let layer: CAGradientLayer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors.compactMap({ $0.cgColor })
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(layer, below: nil)
    }
}
