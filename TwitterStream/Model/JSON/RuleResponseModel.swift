//
//  RuleResponse.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation
struct RulesResponseModel: Codable {
    let data: [RuleModel]?
    let meta: Meta?
}

struct RuleModel: Codable {
    let id: String
    let value: String?
    var tag: String?
}

struct Meta: Codable {
    var sent: String?
    var result: Int?
}
