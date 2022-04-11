//
//  Config.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Foundation

struct Config {
    
    static var shared = Config()
    var endpoint = Endpoint()
    init() { }
    let baseAddress = "https://api.twitter.com/2/tweets/search/stream"
    let bearerToken = "AAAAAAAAAAAAAAAAAAAAAAFxbAEAAAAABEtYJJrR1wvTGUOmA0KZL7mG1jU%3DSh17xDkduu7EpmKc0fLeLwpj3k9HnIZAGOE6DhwZAcSFuXp74q"
    
    struct Endpoint {
         let rules = "/rules"
         let connectStream = "?tweet.fields=created_at,author_id"
    }
}
