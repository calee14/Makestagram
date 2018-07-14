//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Cappillen on 7/11/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Create a new variable called aspect height in UIImage and give change height proportionally to image size
    var aspectheight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
