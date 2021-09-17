//
//  RootWeatherViewModel.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit
import CoreLocation

protocol WeatherLoadingDelegate: NSObjectProtocol {
    func weatherLoaded(result: Result<WeatherAPIResponse, Error>)
}

/**
 This class is in charge of all the business logic on the view, including
 what colors to show, the collection view cell factory, scroll management and more
 */
class RootWeatherViewModel: ViewModel {
    
    /// The previous weather response
    var currentWeather: WeatherAPIResponse? {
        didSet {
            //  Reload the table
            DispatchQueue.main.async {
                self.collection?.reloadData()
            }
        }
    }
    
    /// The current collection view on the deck
    weak var collection: UICollectionView?
    
    /// The current weather loading delegate
    weak var delegate: WeatherLoadingDelegate?
    
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
        WeatherAPIRequestManager.getLocationMockReponse(
            forLocation: CLLocationCoordinate2D(latitude: 72.22, longitude: 33.11)
        ) { [weak self] result in
            guard let wSelf = self else { return }
            switch result {
            case .failure(let err):
                wSelf.show(message: err.localizedDescription)
            case .success(let response):
                wSelf.currentWeather = response
            }
            wSelf.delegate?.weatherLoaded(result: result)
        }
    }
    
    deinit {
        collection = nil
        delegate = nil
    }
    
}

//  MARK: - Actions
extension RootWeatherViewModel {
    
    /// Reloads the view, if available from the API
    @IBAction
    func reloadView() {
        show(message: "Reloading")
    }
    
    /// Request the permissions for location, if required
    @IBAction
    func requestPermissionIfNeeded() {
        show(message: "Permissions Required")
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
        self.currentWeather?.daily.count ?? 0
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
        
        //  Get the current day
        guard let response = currentWeather
        else { return UICollectionViewCell() }
        let day = response.daily[indexPath.row]
        
        //  Setup the cell
        currentCell.set(
            date: Date(timeIntervalSince1970: TimeInterval(day.dt)),
            low: String(Int(day.temp.min)),     //  Set as int as no one cares about decimal
            high: String(Int(day.temp.max)),    //  ^ 
            iconURL: day.weather.first?.iconURL ?? "",
            updatedTime: Date()
        )
        
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        //  Get the current controller
        guard let startingController = viewController
        , let weather = currentWeather
        else { return }
        
        //  Show the details for the day with teh specified ID
        ViewRouter.showDetails(
            forLocation: weather,
            fromController: startingController
        )
    }
    
}
