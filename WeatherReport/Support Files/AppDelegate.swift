//
//  AppDelegate.swift
//  WeatherReport
//
//  Created by Jack on 6/24/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initSetup()
        
        return true
    }
    
    private func initSetup() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().isTranslucent = true
        //UINavigationBar.appearance().tintColor = .white
        
        let mainWeatherVC = MainWeatherVC()
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = mainWeatherVC
        window?.makeKeyAndVisible()
    }
    
}

