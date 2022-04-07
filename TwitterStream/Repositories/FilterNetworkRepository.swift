//
//  FilterNetworkRepository.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import RxSwift
import RxCocoa
import Alamofire


struct FilterNetworkRepository {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func addRule(with keyword: String) -> Observable<RulesResponseModel> {
        client.request(Router.addRule(key: keyword))
    }
}

extension FilterNetworkRepository {
    enum Router: NetworkRouter {
        case getRules
        case addRule(key: String)
        case delete
        case search
        
    }
}
