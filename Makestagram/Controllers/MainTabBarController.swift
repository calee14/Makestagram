//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Cappillen on 7/10/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let photoHelper = MGPhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the MainTabBarController as the delegate of its tab bar
        delegate = self
        
        // UI - set color
        tabBar.unselectedItemTintColor = .black
        
        // When the user has finished taking the image
        photoHelper.completionHandler = { image in
            // Make a new post
            PostService.create(for: image)
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // present photo taking action sheet
            photoHelper.presentActionSheet(from: self)
            return false
        } else {
            return true
        }
    }
}
