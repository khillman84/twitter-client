//
//  Tweet.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/20/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import Foundation

class Tweet {
    let text : String
    let id : String
//    let retweetStatus : Bool
    let retweetCount : Int
    
    var user : User?
    
    init?(json: [String : Any]) {
//        if json["retweeted_status"] == nil {
//            self.retweetStatus = false
//        } else {
//            self.retweetStatus = true
//        }
        
        if let text = json["text"] as? String, let retweetCount = json["retweet_count"] as? Int, let id = json["id_str"] as? String {
            self.text = text
            self.id = id
            self.retweetCount = retweetCount
            if let userDictionary = json["user"] as? [String : Any]{
                self.user = User(json: userDictionary)
            }
        } else {
            return nil
        }
    }
}
