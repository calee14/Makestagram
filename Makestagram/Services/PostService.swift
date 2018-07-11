//
//  PostService.swift
//  Makestagram
//
//  Created by Cappillen on 7/10/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadUrl) in
            guard let downloadUrl = downloadUrl else {
                return
            }
            
            let urlString = downloadUrl.absoluteString
            let aspectHeight = image.aspectheight
            create(forUrlString: urlString, aspectHeight: aspectHeight)
        }
    }
    public static func create(forUrlString urlString: String, aspectHeight: CGFloat) {
        
        let currentUser = User.current
        
        let post = Post(imageUrl: urlString, imageHeight: aspectHeight)
        
        let dict = post.dictValue
        
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        
        postRef.updateChildValues(dict)
    }
}
