//
//  MGPhotoHelper.swift
//  Makestagram
//
//  Created by Cappillen on 7/10/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class MGPhotoHelper: NSObject {
    
    // MARK: - Properties
    
    var completionHandler: ((UIImage) -> Void)?
    
    // MARK: - Helper Methods
    
    func presentActionSheet(from viewController: UIViewController) {
        // Initialize a new alert contrller to present different kinds of alerts
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture", preferredStyle: .actionSheet)
        
        // Check if the current device has a camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // Create a new alert action for the camera
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { action in
                // Present a camera to take a picture
                self.presentImagePickerController(with: .camera, from: viewController)
            })
            
            // Add the action to the alert controller
            alertController.addAction(capturePhotoAction)
        }
        
        // Check if the current device has the photo library available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            // Create a new alert action
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { action in
                // Present the photo library
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })
            alertController.addAction(uploadAction)
        }
        // Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Have the currne view contrller present the alert controller 
        viewController.present(alertController, animated: true)
    }
    
    // Present the correct image picker controller
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
    }
}

extension MGPhotoHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Implement the delegate methods for when user is done picking the image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completionHandler?(selectedImage)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
