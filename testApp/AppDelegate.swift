//
//  AppDelegate.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: MainViewController(presenter: MainPresenter()))
        navigationController.navigationBar.backgroundColor = .white
        window?.rootViewController = navigationController
        return true
    }
}

