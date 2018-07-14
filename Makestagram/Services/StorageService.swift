//
//  StorageService.swift
//  Makestagram
//
//  Created by Cappillen on 7/10/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit
import FirebaseStorage

struct StorageService {
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping(URL?) -> Void) {
        // Change the image to Data and reduce the quality of the image so it will be faster to upload
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        // Get the path to where the data will be stored and store it there
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // Error handling
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Get the url of the image
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                // Return the URL of the image
                completion(url)
            })
        })
    }
}
