//
//  RootWeatherViewModel.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 This class is in charge of all the business logic on the view, including
 what colors to show, the collection view cell factory, scroll management and more
 */
class RootWeatherViewModel: ViewModel {
    
    /// Determine the current colors to show, live, when needed
    /// This will be placed in the gradient
    var currentColors: [UIColor] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 0...6
             , 20...24:
            return [
                .blue
                , .black
            ]
        case 7...8
             , 18...19:
            return [
                .red
                , .orange
                , .blue
            ]
        default:
            return [
                .blue
                , .white
                , .green
            ]
        }
    }
    
    override init() {
        super.init()
        //  Check location authorisation
    }
    
}

//  MARK: - Actions
extension RootWeatherViewModel {
    
    /// Reloads the view, if available from the API
    @IBAction
    func reloadView() {
        print("reloading View")
    }
    
    /// Request the permissions for location, if required
    @IBAction
    func requestPermissionIfNeeded() {
        print("Checking location permissions")
    }
    
}

//  MARK: - UICollection View Data Source and delegate for layout
extension RootWeatherViewModel: UICollectionViewDelegateFlowLayout
                                , UICollectionViewDataSource {
    
    /// Get the number of items in the collection. Be sure to handle zero state
    /// - Parameters:
    ///   - collectionView: The collection view with number of items
    ///   - section:        The section requesting the data
    /// - Returns:          The number of items in the current section
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let currentCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "com.weather.small_cell",
                for: indexPath
        ) as? SmallWeatherCollectionViewCell
        else { return UICollectionViewCell() }
        
        return currentCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.width/1.75,
            height: collectionView.frame.height
                - (Constants.offset * 2)
        )
    }
    
}
