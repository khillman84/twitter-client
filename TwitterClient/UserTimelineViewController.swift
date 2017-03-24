//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/23/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {
    
    var tweetText = [Tweet]()

    
    @IBOutlet var userTimeline: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTweetsFor()
    }
    
    func getTweetsFor(){
        
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.tweetText = tweets ?? []
            }
        }
    }
}
