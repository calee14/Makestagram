//
//  UserService.swift
//  Makestagram
//
//  Created by Cappillen on 7/9/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username":username]
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
    
    static func posts(for user: User, completion: @escaping ([Post]) -> Void) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let dispatchGroup = DispatchGroup()
            let posts: [Post] = snapshot.reversed().compactMap {
                guard let post = Post(snapShot: $0) else { return nil }
                
                dispatchGroup.enter()
                
                LikeService.isPostLiked(post) { (isLiked) in
                    post.isLiked = isLiked
                    
                    dispatchGroup.leave()
                }
                
                return post
                
            }
            dispatchGroup.notify(queue: .main, execute: {
                completion(posts)
            })
        })
    }
}
