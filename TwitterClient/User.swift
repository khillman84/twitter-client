//
//  User.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/20/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import Foundation


class User {
    let name : String
    let profileImageURL : String
    let location : String
    let screenName : String
    let bio : String
    let backgroundImageURL : String
    
    init?(json: [String : Any]) {
        print(json)
        
        if let name = json["name"] as? String,
            let profileImageURL = json["profile_image_url_https"] as? String,
            let location = json["location"] as? String,
            let screenName = json["screen_name"] as? String,
            let bio = json["description"] as? String,
            let backgroundImageURL = json["profile_banner_url"] as? String {
            
            self.name = name
            self.profileImageURL = profileImageURL
            self.location = location
            self.screenName = screenName
            self.bio = bio
            self.backgroundImageURL = backgroundImageURL
        } else {
            return nil
        }
    }
}
