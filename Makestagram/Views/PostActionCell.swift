//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Cappillen on 7/12/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}
class PostActionCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    static let height: CGFloat = 46
    
    weak var delegate: PostActionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
}
