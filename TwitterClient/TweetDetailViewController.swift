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
    @IBOutlet weak var retweetText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.tweet.user?.name ?? "Unkown")
        print(self.tweet.text)
        
        singleTweet.text = self.tweet.text
        userName.text = self.tweet.user?.name
        retweetText.text = String(self.tweet.retweetStatus)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == UserTimelineViewController.identifier {
                
                guard let destinationController = segue.destination as? UserTimelineViewController else { return }
                
                destinationController.screenName = tweet.user!.screenName
        }
    }
}
