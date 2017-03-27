//
//  TweetNibCell.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/23/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            let count = String(tweet.retweetCount)
            
            self.tweetLabel.text = tweet.text
            self.usernameLabel.text = tweet.user?.name ?? "Unkown User"
            
            if tweet.retweetCount >= 0 {
                self.retweetCount.text = "Retweet: \(count)"
            }
            
            if let user = tweet.user {
                UIImage.fetchImageWith(user.profileImageURL) { (image) in
                    self.userImageView.image = image
                }
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
