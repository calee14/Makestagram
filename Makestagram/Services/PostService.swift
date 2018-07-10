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
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadUrl) in
            guard let downloadUrl = downloadUrl else {
                return
            }
            
            let urlString = downloadUrl.absoluteString
            print("image url: \(urlString)")
        }
    }
}
