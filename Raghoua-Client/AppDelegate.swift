//
//  AppDelegate.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit
import GoogleMaps
import MOLH
//AIzaSyDDN8kxOEXKznFoCeiXXFCMiinpCvj8Gsc

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDDN8kxOEXKznFoCeiXXFCMiinpCvj8Gsc")
        MOLHLanguage.setDefaultLanguage("ar")
        MOLH.shared.activate(true)
//        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

