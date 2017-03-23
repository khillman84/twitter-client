//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/22/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet : Tweet!
    
    @IBOutlet weak var singleTweet: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.tweet.user?.name ?? "Unkown")
        print(self.tweet.text)
        
        singleTweet.text = self.tweet.text
        userName.text = self.tweet.user?.name
    }

    
}
