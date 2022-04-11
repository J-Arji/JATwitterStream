//
//  AppFlowDelegate.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import UIKit

/// `AppFlow` make change flow app
enum AppFlow {
    case splash
    case main
    
    var viewController: UIViewController {
        switch self {
        case  .splash:
            let vc = UINavigationController(rootViewController: TweetView())  
            return vc
        case  .main: return UIViewController()
        }
    }
}


/// `AppFlowDelegate` make change flow app

protocol AppFlowDelegate {
    func changeFlow(to flow: AppFlow)
}

extension AppFlowDelegate where Self: AppDelegate {
    
    private var transition: CATransition {
        let transition = CATransition()
        transition.type =  .reveal
        transition.duration = 0.5
        return transition
    }
    
    func changeFlow(to flow: AppFlow) {
        window?.rootViewController = nil
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.layer.add(transition, forKey: kCATransition)
        window!.rootViewController = flow.viewController
        window!.makeKeyAndVisible()
    }
    
}
extension AppDelegate: AppFlowDelegate {}

