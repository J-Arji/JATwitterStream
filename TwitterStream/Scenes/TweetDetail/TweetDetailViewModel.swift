//
//  TweetDetailViewModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/11/22.
//

import Foundation

struct TweetDetailViewModel {
    var tweet: TweetInterface
    
    init(tweet: TweetInterface) {
        self.tweet = tweet
    }
}
