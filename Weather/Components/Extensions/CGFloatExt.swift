//
//  CGFloatExt.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import Foundation
import UIKit

extension CGFloat {
    
    var sizeValue: CGSize
    { CGSize(width: self, height: self) }
    
    var insetValue: UIEdgeInsets
    { UIEdgeInsets(top: self, left: self, bottom: self, right: self)}
    
}
