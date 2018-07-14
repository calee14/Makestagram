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
        // Upload image to Firebase
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadUrl) in
            guard let downloadUrl = downloadUrl else {
                return
            }
            
            // Get URL string
            let urlString = downloadUrl.absoluteString
            let aspectHeight = image.aspectheight
            create(forUrlString: urlString, aspectHeight: aspectHeight)
        }
    }
    public static func create(forUrlString urlString: String, aspectHeight: CGFloat) {
        
        let currentUser = User.current
        let post = Post(imageUrl: urlString, imageHeight: aspectHeight)
        
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        FollowService.followers(for: currentUser) { (followerUIDs) in
            
            let timelinePostDict = ["poster_uid": currentUser.uid]
            
            var updatedData: [String: Any] = ["timeline/\(currentUser.uid)/\(newPostKey)": timelinePostDict]
            
            for uid in followerUIDs {
                updatedData["timeilne/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            let postDict = post.dictValue
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            rootRef.updateChildValues(updatedData)
        }
    }
    
    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapShot: snapshot) else {
                return completion(nil)
            }
            
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
}
