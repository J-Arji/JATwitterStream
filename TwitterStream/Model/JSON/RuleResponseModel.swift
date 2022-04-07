//
//  RuleResponse.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
struct RulesResponseModel: Codable {
    let data: [RuleModel]
    
}

struct RuleModel: Codable {
    let id: String
    let value: String?
    let tag: String?
}


