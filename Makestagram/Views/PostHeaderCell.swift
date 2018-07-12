//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Cappillen on 7/11/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let height: CGFloat = 54
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("Options button tapped")
    }
    
    
}
