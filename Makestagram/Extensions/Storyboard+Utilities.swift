//
//  Storyboard+Utitlities.swift
//  Makestagram
//
//  Created by Cappillen on 7/9/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // Create a new enum called MGType (stands for Makestagram Type enum)
    enum MGType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    // Method to create the new storyboard with the use of the enum
    static func initializeViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Could not instantiate initial view controller for \(type.filename) storyboard")
        }
        return initialViewController
    }
}
