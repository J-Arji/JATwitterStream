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
    let bearerToken = "AAAAAAAAAAAAAAAAAAAAAAFxbAEAAAAAtTxZJi8gt5J%2FMjOKj8BLeSDxECA%3DAb1gVhfbErajdWCgSJJMIWnhjPVqnKjOdFFmRiyxL6sO2pz455"
    
    struct Endpoint {
         let rules = "/rules"
         let connectStream = "?tweet.fields=created_at,author_id"
    }
}
