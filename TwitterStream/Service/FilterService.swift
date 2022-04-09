//
//  FilterService.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation

protocol FilterService {
    func addRule(keyword: String, completion: @escaping RuleResponseOutput)
    func getRules(completion: @escaping RuleResponseOutput)
    func deleteRules(with ruleIds: [String], completion: @escaping DeleteRuleResponseOutput)
    func fetch(completion: @escaping FeedResponseModelOutput)
    
}


class FilterServiceImp: FilterService {
   
    
  
    
    private let networkRepo: FilterNetworkRepository
    
    required init(network: FilterNetworkRepository) {
        networkRepo = network
    }
 
    
    func addRule(keyword: String, completion: @escaping RuleResponseOutput){
        networkRepo.addRule(keyword: keyword, completion: completion)
    }
    func getRules(completion: @escaping RuleResponseOutput) {
        networkRepo.getRules(completion: completion)
    }
    
    func deleteRules(with ruleIds: [String], completion: @escaping DeleteRuleResponseOutput) {
        networkRepo.deleteRules(with: ruleIds, completion: completion)
    }
    
    func fetch(completion: @escaping FeedResponseModelOutput) {
        networkRepo.fetch(completion: completion)
        
    }
}

