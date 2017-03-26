//
//  UserViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/22/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user = [User]() {
        didSet {
            self.userView.reloadData()
        }
    }
    
    
    @IBOutlet weak var userView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User"
        self.userView.dataSource = self
        
        let userNib = UINib(nibName: "UserNibCell", bundle: nil)
        self.userView.register(userNib, forCellReuseIdentifier: UserNibCell.identifier)
        
        self.userView.delegate = self
        self.userView.estimatedRowHeight = 50
        self.userView.rowHeight = UITableViewAutomaticDimension
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = [user!]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserNibCell.identifier, for: indexPath) as! UserNibCell
        
        let user = self.user[indexPath.row]
        cell.user = user 
        
        return cell
    }
}
