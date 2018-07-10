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
    
    init(imageUrl: String, imageHeight: CGFloat) {
        self.imageUrl = imageUrl
        self.imageHeight = imageHeight
        self.creationDate = Date()
    }
    
}
