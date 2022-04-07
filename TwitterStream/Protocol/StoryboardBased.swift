//
//  StoryboardBased.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
import UIKit
/// A protocol that lets us instantiate view controllers from Main storyboard.
protocol Storyboarded {
    static func instantiate(storyboard: String) -> Self
    static func instantiateNib() -> Self
}


extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboard: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
    static func instantiateNib() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        return Self(nibName: className, bundle: nil)
    }
}
