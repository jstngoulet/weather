//
//  RootWeatherViewController.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit
import PureLayout

/**
 The primary controller on the view. Houses the summary
 */
class RootWeatherViewController: CommonViewController {
        
    private lazy var mainTempLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 100)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.text = "--"
        lbl.textColor = .white
        lbl.shadowColor = .darkGray
        lbl.shadowOffset = CGFloat(2).sizeValue
        return lbl
    }()
    
    private lazy var degreeLabel: UILabel = {
       let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = mainTempLabel.font
        lbl.adjustsFontSizeToFitWidth = true
        lbl.text = "º"
        lbl.textColor = .white
        lbl.shadowColor = .darkGray
        lbl.shadowOffset = CGFloat(2).sizeValue
        return lbl
    }()
    
    private lazy var locationLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = .white
        lbl.text = "Location Permission Required"
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.shadowColor = .darkGray
        lbl.shadowOffset = CGFloat(2).sizeValue
        return lbl
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "house_img")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collection.autoSetDimension(.height, toSize: view.frame.height/2.5)
        collection.dataSource = viewModel
        collection.delegate = viewModel
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        
        collection.register(
            SmallWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: "com.weather.small_cell"
        )
        
        return collection
    }()
    
    private lazy var collectionLayout: UICollectionViewLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = Constants.offset
        layout.sectionInset.right = Constants.offset
        layout.minimumInteritemSpacing = Constants.offset
        return layout
    }()
    
    private lazy var viewModel: RootWeatherViewModel = {
        let model = RootWeatherViewModel()
        model.viewController = self
        return model
    }()
    
    /// Lifecycle function to load the view
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Weather"
        build()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

//  MARK: - Build and Construct the view
private extension RootWeatherViewController {
    
    /// Wrapper function to build the view
    func build() {
        addSubviews()
        setContraints()
        
        //  Add the navigation button for location permission
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "outline_location_on_white_36pt")?
                .withRenderingMode(.alwaysTemplate),
            style: .plain,
            target: viewModel,
            action: #selector(viewModel.requestPermissionIfNeeded)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "outline_refresh_white_36pt")?
                .withRenderingMode(.alwaysTemplate),
            style: .plain,
            target: viewModel,
            action: #selector(viewModel.reloadView)
        )
        
        //  Set the gradient on the view
        view.setGradient(colors: viewModel.currentColors)
    }
    
    /// Adds the children views to the parent
    func addSubviews() {
        view.addChildren([
            mainTempLabel
            , degreeLabel
            , locationLabel
            , backgroundImageView
            , collectionView
        ])
    }
    
    /// Sets the constraints on the children views
    func setContraints() {
        mainTempLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: Constants.offset)
        mainTempLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        degreeLabel.autoPinEdge(.top, to: .top, of: mainTempLabel)
        degreeLabel.autoPinEdge(.bottom, to: .bottom, of: mainTempLabel)
        degreeLabel.autoPinEdge(.left, to: .right, of: mainTempLabel)
        
        locationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.offset)
        locationLabel.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.offset)
        locationLabel.autoPinEdge(.top, to: .bottom, of: mainTempLabel,
                                  withOffset: Constants.offset)
        
        backgroundImageView.autoPinEdge(toSuperviewEdge: .left, withInset: Constants.offset)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .right, withInset: Constants.offset)
        backgroundImageView.autoPinEdge(.top, to: .bottom, of: locationLabel, withOffset: Constants.offset)
        backgroundImageView.autoPinEdge(.bottom, to: .top, of: collectionView, withOffset: -Constants.offset)
        
        collectionView.autoPinEdgesToSuperviewSafeArea(
            with: .zero,
            excludingEdge: .top
        )
    }
    
}
