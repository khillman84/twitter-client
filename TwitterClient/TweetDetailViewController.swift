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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.tweet.user?.name ?? "Unkown")
        print(self.tweet.text)
    }


}
