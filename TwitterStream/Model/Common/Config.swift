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
         let connectStream = "?tweet.fields=created_at&expansions=author_id,geo.place_id&user.fields=created_at&place.fields=contained_within,country,full_name,geo,id,name,place_type"
    }
}

struct TwitterServiceConstants {
    struct RequestParamKeys {
        static let add = "add"
        static let tag = "tag"
        static let value = "value"
        static let ids = "ids"
    }

    struct RequestParamValues {
        static let sample = "has:images"
    }
}


