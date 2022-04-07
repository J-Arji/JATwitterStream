//
//  RepositoriesDependencyContainer.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
final class RepositoriesDependencyContainer {
    private let client: APIClient
    
    init(client: APIClient = APIClientImp()) {
        self.client = client
    }
}
