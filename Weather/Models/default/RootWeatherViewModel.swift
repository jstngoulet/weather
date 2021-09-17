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
    
    /// Could be loaded from somewhere else
    struct ViewText: Codable {
        var needLocationText: String    = "Location Permissions Needed"
        var loadingText: String         = "Loading Weather"
        var restrictedText: String      = "Location Permissions Limited"
    }
    
    /// The current text for the page
    private(set) var currentText: ViewText = ViewText()
    
    var locationText: String {
        guard let locationStatus = previousAuthStatus
        else { return currentText.needLocationText }
        
        switch locationStatus {
        case .notDetermined:
            return currentText.needLocationText
        case .restricted
             , .denied:
            return currentText.restrictedText
        case .authorizedAlways
             , .authorizedWhenInUse:
            return currentText.loadingText
        @unknown default: return currentText.needLocationText
        }
    }
    
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
    
    /// Set the auth status as it changes
    private var previousAuthStatus: CLAuthorizationStatus?
    
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
                , .blue
                , .white
                , .green
                , .brown
            ]
        }
    }
    
    /// The location manager for determining location
    private lazy var locationMgr: CLLocationManager = {
       let mgr = CLLocationManager()
        mgr.delegate = self
        return mgr
    }()
    
    override init() {
        super.init()
        //  Check location authorisation
        locationMgr.desiredAccuracy = .leastNonzeroMagnitude    //  Creates instance
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
        guard let currentLocation = locationMgr.location?.coordinate
        else { return }
        
        WeatherAPIRequestManager.getLocationResponse(
            forLocation: CLLocationCoordinate2D(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude
            )
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
    
    /// Request the permissions for location, if required
    @IBAction
    func requestPermissionIfNeeded() {
        if let currentAuth = previousAuthStatus
           , currentAuth == .notDetermined {
            //  Request Permission
            locationMgr.requestWhenInUseAuthorization()
        } else {
            show(message: "Location already determined")
        }
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
        
        //  Report Analytcs
        
        //  Show the details for the day with teh specified ID
        ViewRouter.showDetails(
            forLocation: weather,
            fromController: startingController
        )
    }
    
}

//  Location Permissions
extension RootWeatherViewModel: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        //  Report Analyticss
        
        //  if successful, reload. else, do nothing
        if [
            .authorizedAlways
            , .authorizedWhenInUse
        ].contains(status) {
            //  Reload the view
            reloadView()
        } else {
            //   do nothing
        }
        
        //  Keep the status updated.
        //  If this is first attempt, reload
        if previousAuthStatus == nil {
            previousAuthStatus = status
            reloadView()
        }
    }
    
    /// Location manager errors. Crashes if this function is not present
    /// - Parameters:
    ///   - manager:    The current lcoation manager
    ///   - error:      The error that was found on location updates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        show(message: "Location manager failure: \(error.localizedDescription)")
    }
    
}
