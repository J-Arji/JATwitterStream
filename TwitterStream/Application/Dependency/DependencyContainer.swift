//
//  DependencyContainer.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
final class DependencyContainer {
    
    static var shared = DependencyContainer()
    private init() {}
    
    private(set) lazy var services = ServicesDependencyContainer()
    
}
