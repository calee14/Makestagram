//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Cappillen on 7/9/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CreateUsernameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Check if the user is logged in and that the user has provided a username in the text field
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        // Use the service to create a new user
        UserService.create(firUser, username: username, completion: { (user) in
            // Get the user from the callback
            guard let user = user else { return }
            
            // Set the new user to be the current one
            User.setCurrent(user, writeToUserDefaults: true)
            
            // Create a new instance of the main story board
            let initialViewController = UIStoryboard.initializeViewController(for: .main)
            
            // Get the storyboard has a initial controller
            self.view.window?.rootViewController = initialViewController
            // Display the viewcontroller 
            self.view.window?.makeKeyAndVisible()
        })
    }
}
