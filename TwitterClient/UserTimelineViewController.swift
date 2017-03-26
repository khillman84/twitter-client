//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/23/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var screenName : String!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User Timeline"
        self.tableView.dataSource = self
        
        let userTweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        self.tableView.register(userTweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        API.shared.getTweetsFor(screenName) { (tweets) in
            OperationQueue.main.addOperation {
                self.tweets = tweets ?? []
            }
        }

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }

}
























