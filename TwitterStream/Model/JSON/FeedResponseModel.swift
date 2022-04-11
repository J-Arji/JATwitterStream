//
//  FeedResponseModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation

protocol TweetInterface {
    var text: String? { get }
    var author_id: String? { get }
}

struct Tweet: Codable {
    let data: DataTweet
}

struct DataTweet: Codable {
    
    let author_id: String?
    let created_at: String
    let id: String?
    let text: String?
}
extension DataTweet: TweetInterface {}
