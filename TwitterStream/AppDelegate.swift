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
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UIViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }

}

