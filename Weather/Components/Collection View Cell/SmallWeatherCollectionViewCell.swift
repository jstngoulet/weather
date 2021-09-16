//
//  SmallWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 Class for the collection view cel
 */
class SmallWeatherCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.25)
        layer.maskedCorners = [
            .layerMaxXMaxYCorner
            , .layerMinXMinYCorner
            , .layerMinXMinYCorner
            , .layerMaxXMaxYCorner
        ]
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGFloat(2).sizeValue
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
