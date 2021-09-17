//
//  SmallWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit
import AlamofireImage

/**
 Class for the collection view cel
 */
class SmallWeatherCollectionViewCell: UICollectionViewCell {
    
    /// The label that will display the active hour
    private lazy var shownDayLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textColor = .gray
        lbl.text = "Day of Week"
        return lbl
    }()
    
    /// The current weather image
    private lazy var weatherImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imgView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imgView.image = UIImage(named: "season_change")
        imgView.autoresizingMask = .flexibleHeight
        return imgView
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.addArrangedSubview(lowItem)
        stack.addArrangedSubview(highItem)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Constants.offset
        return stack
    }()
    
    private lazy var lowItem: TempLabel = {
        TempLabel(
            withTitle: "---",
            detail: "Low"
        )
    }()
    
    private lazy var highItem: TempLabel = {
        TempLabel(
            withTitle: "---",
            detail: "High"
        )
    }()
    
    private lazy var borderView: UIView = {
       let vew = UIView()
        vew.backgroundColor = .gray
        vew.autoSetDimension(.width, toSize: 1)
        vew.layer.cornerRadius = 1/2
        vew.layer.masksToBounds = true
        return vew
    }()
    
    private lazy var lastUpdatedLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.preferredFont(forTextStyle: .caption2)
        lbl.textColor = .gray
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.text = "Last Updated:\n Feb 23, 2021 @ 10:12a"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.maskedCorners = [
            .layerMaxXMaxYCorner
            , .layerMinXMinYCorner
            , .layerMinXMinYCorner
            , .layerMaxXMaxYCorner
        ]
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGFloat(16).sizeValue
        layer.cornerRadius = 16
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SmallWeatherCollectionViewCell {
    
    func build() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        addChildren([
            shownDayLabel
            , weatherImageView
            , stackView
            , borderView
            , lastUpdatedLabel
        ])
    }
    
    func setConstraints() {
        shownDayLabel.autoPinEdgesToSuperviewEdges(
            with: Constants.offset.insetValue,
            excludingEdge: .bottom
        )
        
        weatherImageView.autoPinEdge(.left, to: .left, of: shownDayLabel)
        weatherImageView.autoPinEdge(.right, to: .right, of: shownDayLabel)
        weatherImageView.autoPinEdge(.top, to: .bottom, of: shownDayLabel,
                                     withOffset: Constants.offset)
    
        stackView.autoPinEdge(toSuperviewEdge: .left)
        stackView.autoPinEdge(toSuperviewEdge: .right)
        stackView.autoPinEdge(.top, to: .bottom, of: weatherImageView)
        stackView.autoPinEdge(.bottom, to: .top, of: lastUpdatedLabel)
        
        borderView.autoPinEdge(.top, to: .top, of: stackView,
                               withOffset: Constants.offset)
        borderView.autoPinEdge(.bottom, to: .bottom, of: stackView,
                               withOffset: -Constants.offset)
        borderView.autoAlignAxis(.vertical, toSameAxisOf: stackView)
        
        lastUpdatedLabel.autoPinEdgesToSuperviewEdges(
            with: Constants.offset.insetValue,
            excludingEdge: .top
        )
        
        //  Layout the subviews, then keep the image view size
        layoutSubviews()
        weatherImageView.autoSetDimension(.height, toSize: weatherImageView.frame.height)
    }
    
}

extension SmallWeatherCollectionViewCell {
    
    /// Sets the content on the cell
    /// - Parameters:
    ///   - date: the date in which is being applied
    ///   - low: Th low for the given day
    ///   - high: The high for the given time
    ///   - iconURL: The icon url to display in the image view
    ///   - updatedTime: The updated time in which the data was fetched
    func set(
        date: Date
        , low: String
        , high: String
        , iconURL: String
        , updatedTime: Date 
    ) {
        //  Show the date.time
        let longFormatter = DateFormatter()
        longFormatter.dateFormat = "EEEE, M/dd"
        shownDayLabel.text = longFormatter.string(from: date)
        
        weatherImageView.af.setImage(
            withURL: URL(string: iconURL)!,
            cacheKey: iconURL,
            placeholderImage: UIImage(named: "season_change"),
            serializer: nil,
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue(label: "com..weather.image"),
            imageTransition: .noTransition,
            runImageTransitionIfCached: false,
            completion: nil
        )
        
        lowItem.set(title: low)
        highItem.set(title: high)
        
        longFormatter.dateFormat = "EEEE, MMM d @ hh:mm a"  //  Should be in model
        lastUpdatedLabel.text = "Last Updated:\n"
            + longFormatter.string(from: updatedTime)
    }
    
}
