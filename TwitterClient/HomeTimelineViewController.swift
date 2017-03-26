//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/20/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweetText = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        self.tableView.dataSource = self
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
    
        updateTimeline()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.tweetText[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                
                destinationController.tweets = [selectedTweet]
            }
        }
        if segue.identifier == "showUserSegue" {
            guard segue.destination is UserViewController else { return }
        }
    }

    
    func updateTimeline(){
        
        self.activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            OperationQueue.main.addOperation {
                self.tweetText = tweets ?? []
                self.activityIndicator.stopAnimating()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetText.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.tweetText[indexPath.row]
        cell.tweet = tweet

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
    }
    
}






















