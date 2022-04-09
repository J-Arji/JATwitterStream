//
//  DeleteModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//

import Foundation
struct DeletModel: Codable {
    var delete: IdsModel
}

struct IdsModel:Codable {
    var ids: [String]
}
