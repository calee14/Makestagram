//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by Cappillen on 7/11/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    // Create the reference in the storage for the image
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
