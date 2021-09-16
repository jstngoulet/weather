//
//  AppManager.swift
//  Weather
//
//  Created by Justin Goulet on 9/15/21.
//

import UIKit

/**
 This class is the parent of all managers.
 
 We want to be able to create a basic manager class for all AppDelegate Functions
 so that we may easily set up each additonal service as they are added.
 
 This will include any analytic event, API connection, or first view that we want to show to the user.
 
 Normally, We will consider the authentication of the user in the first view,
 but we do not need to do that as we are not authethenticating users nor
 performing any advanced analytics
 */
class AppManager: NSObject,
                  AppManagerDelegate {
    
    /// The curent singleton instance of the app manager, so it is only
    /// created once in the application lifecycle
    static var `default`: AppManager = AppManager()
    
    private lazy var appManagers: [AppManager] = {
       []   //  Currently, we do not have any children of this
    }()
    
    private lazy var window: UIWindow = {
       let mainWindow = UIWindow()
        mainWindow.makeKeyAndVisible()
        return mainWindow
    }()
    
    /// Determines and shows the first controller.
    /// This must wait until after init as we need the initialized application
    /// - Parameter app: The application that was initializd
    private func showFirstController(for app: UIApplication) {
        let startingRoot = CommonViewController()
        startingRoot.view.backgroundColor = .red
        
        let startingController: UINavigationController = UINavigationController(
            rootViewController: startingRoot
        )
        startingRoot.customizeNavBar()
        
        window.rootViewController = startingController
        window.becomeKey()
    }
    
    /// Setup all managers (dependancies) included in the project
    /// - Parameters:
    ///   - application:    The primary application
    ///   - launchOptions:  The launch options for the application
    /// - Returns:          Whether or not the application was successfully launched
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        //  We can determine the first controller before setting up the services
        //  This will change as more auth is added
        showFirstController(for: application)
        
        //  If any of the services fail to launch, devs need to understand why
        return !appManagers
            .compactMap({
                            $0.application(
                                application,
                                didFinishLaunchingWithOptions: launchOptions
                            )
            })
            .contains(false)
    }
    

}

/**
 In order to ensure each App Manager follows the correct methods, we want to
 create a protocol that each App Manager must follow, as the parent will
 define the initial and each child class will inherit from
 */
protocol AppManagerDelegate: NSObjectProtocol {
    
    /// Function for when the app delegate is called, and each service should be
    /// initially setup
    /// - Parameters:
    ///   - application:    The primmary application we want to initialize
    ///   - launchOptions:  The launch options, including any URL that opened the app
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool
}
