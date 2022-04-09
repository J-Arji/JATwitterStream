//
//  Delete.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation
struct DeleteRuleResponse: Codable {
    let meta: DeleteRuleSummary
}
struct DeleteRuleSummary: Codable {
    let summary: DeleteRule
}

struct DeleteRule: Codable {
    let deleted: Int?
}
