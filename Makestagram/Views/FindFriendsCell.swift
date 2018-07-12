//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by Cappillen on 7/12/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class FindFriendsCell: UITableViewCell {
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
        
    }
    @IBAction func followButtonTapped(_ sender: UIButton) {
        print("Follow Button tapped")
    }
    
}
