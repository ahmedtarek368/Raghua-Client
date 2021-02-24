//
//  AppDelegate.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit
import GoogleMaps
import MOLH
import FBSDKCoreKit
//AIzaSyDDN8kxOEXKznFoCeiXXFCMiinpCvj8Gsc


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDDN8kxOEXKznFoCeiXXFCMiinpCvj8Gsc")
        MOLHLanguage.setDefaultLanguage("ar")
        MOLH.shared.activate(true)
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        ApplicationDelegate.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }


}

