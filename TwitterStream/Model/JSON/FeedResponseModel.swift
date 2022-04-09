//
//  FeedResponseModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation

protocol TweetInterface {
    var text: String? { get }

}
struct FeedResponseModel: Codable {
    let feed: FeedModel

    enum CodingKeys: String, CodingKey {
        case feed = "data"
    }
}

struct FeedModel: Codable {    
    
    let feedId: String
    let text: String?
    let geo: FeedGeoModel?

    enum CodingKeys: String, CodingKey {
        case feedId = "id"
        case text
        case geo
    }
}
extension FeedModel: TweetInterface {}

struct FeedGeoModel: Codable {
    let type: String?
    let coordinates: [Double]?
}

