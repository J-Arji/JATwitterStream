//
//  AppDelegate.swift
//  TwitterStream
//
//  Created by javad Arji on 4/6/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.changeFlow(to: .splash)
        return true
    }

}

