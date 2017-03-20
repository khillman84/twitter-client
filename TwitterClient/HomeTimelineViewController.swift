//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/20/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource {
    
    var tweetText = [Tweet]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            if(success){
                guard let tweets = tweets else { fatalError("Tweets came back nil") }
                for tweet in tweets{
                    print(tweet.text)
                    tweetText.append(tweet)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetText.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tweetText[indexPath.row].text
        cell.detailTextLabel?.text = tweetText[indexPath.row].user?.name
        return cell
    }
}
