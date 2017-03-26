//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/22/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets = [Tweet]()




    var screenName : String!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "The Tweet"
        self.tableView.dataSource = self
        
        let userTweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        self.tableView.register(userTweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == UserTimelineViewController.identifier {
            guard let destinationController = segue.destination as? UserTimelineViewController else { return }
                destinationController.screenName = tweets[0].user?.screenName
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
