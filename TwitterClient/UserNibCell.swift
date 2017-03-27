//
//  UserNibCell.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/26/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import UIKit

class UserNibCell: UITableViewCell {


    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bioView: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    
    var user : User! {
        didSet {
            self.userName.text = user?.name ?? "Unkown"
            self.userLocation.text = user?.location ?? "Unkown"
            self.bioView.text = user?.bio ?? "No Bio"

            UIImage.fetchImageWith(user.profileImageURL) { (image) in
                self.userImage.image = image
            }
            
            UIImage.fetchImageWith(user.backgroundImageURL) { (image) in
                self.backImage.image = image
            }
            
        }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
