//
//  UserViewController.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/22/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var user : User!

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }

    func getUser() {
        API.shared.getUserInfo { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                self.userNameLabel.text = user?.name
            }
        }
    }

}
