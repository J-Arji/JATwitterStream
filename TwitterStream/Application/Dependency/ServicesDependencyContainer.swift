//
//  ServicesDependencyContainer.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
final class ServicesDependencyContainer {
    private lazy var repositories = RepositoriesDependencyContainer()
    
    var search: FilterService {
        FilterServiceImp(network: repositories.serchNetwork)
    }
    
}
