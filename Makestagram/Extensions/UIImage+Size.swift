//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Cappillen on 7/11/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectheight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
