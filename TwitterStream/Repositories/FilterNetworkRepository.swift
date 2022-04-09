//
//  FilterNetworkRepository.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
import Alamofire

typealias RuleResponseOutput = ((Result<RulesResponseModel, ClientError>) -> Void)
typealias DeleteRuleResponseOutput = ((Result<DeleteRuleResponse, ClientError>) -> Void)
typealias FeedResponseModelOutput = ((Result<[FeedResponseModel], ClientError>) -> Void)

struct FilterNetworkRepository {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func addRule(keyword: String, completion: @escaping RuleResponseOutput){
        client.request(Router.addRule(key: keyword), completion: completion)
    }
    func getRules(completion: @escaping RuleResponseOutput) {
        client.request(Router.getRules, completion: completion)
    }
    
    func deleteRules(with ruleIds: [String], completion: @escaping DeleteRuleResponseOutput) {
        client.request(Router.delete(id: ruleIds), completion: completion)
    }
    
    func fetch(completion: @escaping FeedResponseModelOutput) {
        client.requestStream(Router.search, completion: completion)
    }
}

extension FilterNetworkRepository {
    
    enum Router: NetworkRouter {
        
        case getRules
        case addRule(key: String)
        case delete(id: [String])
        case search
        
        var path: String {
            switch self {
            case .getRules, .delete, .addRule :
                return Config.shared.endpoint.rules
                
            case .search:
                return Config.shared.endpoint.connectStream
            }
        }
        
        var method: HTTPMethod{
            switch self {
            case .getRules, .search:
                return .get
                
            case .addRule, .delete:
                return .post
                
            }
        }
        
        var headers: [String: String]? {
            return ["Authorization" : "Bearer \(Config.shared.bearerToken)"]
        }
        
        var params: [String : Any]? {
            switch self {
            case .addRule(let keyword):
                let params = InputKeywordModel(value: keyword, tag: keyword)
                let model = AddModel(add: [params])
                return try? model.asDictionary()
                
            case let .delete(ruleIds):
                let dett = DeletModel(delete: IdsModel(ids: ruleIds))
                return try? dett.asDictionary()
                
            default:
                return nil
                
            }
        }
        
    }
}
