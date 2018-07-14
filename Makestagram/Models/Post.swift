//
//  Post.swift
//  Makestagram
//
//  Created by Cappillen on 7/10/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageUrl: String
    let imageHeight: CGFloat
    let creationDate: Date
    var likeCount: Int
    let poster: User
    var isLiked: Bool = false
    
    // Dictionary to hold all of the data
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid": poster.uid,
                        "username": poster.username]
        
        return ["image_url": imageUrl,
                "image_height": imageHeight,
                "created_at": createdAgo,
                "like_count": likeCount,
                "poster": userDict]
    }
    
    init(imageUrl: String, imageHeight: CGFloat) {
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date()
        self.likeCount = 0
        self.poster = User.current
    }
    
    init?(snapShot: DataSnapshot) {
        // Retrieve all the data on a post and save it to the object
        guard let dict = snapShot.value as? [String: Any],
            let imageUrl = dict["image_url"] as? String,
            let imageHeight = dict["image_height"] as? CGFloat,
            let createdAgo = dict["created_at"] as? TimeInterval,
            let likeCount = dict["like_count"] as? Int,
            let userDict = dict["poster"] as? [String: Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil}
        
        self.key = snapShot.key
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username)
        
    }
}
