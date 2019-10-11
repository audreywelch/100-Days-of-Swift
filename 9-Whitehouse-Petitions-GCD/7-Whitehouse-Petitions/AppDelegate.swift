//
//  AppDelegate.swift
//  7-Whitehouse-Petitions
//
//  Created by Audrey Welch on 10/3/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            // Create a view controller that is the same as the one we created in the storyboard
            let vc = storyboard.instantiateViewController(identifier: "NavController")

            // Create a tab bar item object for the new view controller
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)

            // Add the new view controller to our tab bar controller's viewControllers array
            tabBarController.viewControllers?.append(vc)
        }
        
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

