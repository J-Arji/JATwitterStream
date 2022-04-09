//
//  AddModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//

import Foundation
struct AddModel: Codable {
    var add: [InputKeywordModel]
}
struct InputKeywordModel: Codable {
    var value: String?
    var tag: String?
}



