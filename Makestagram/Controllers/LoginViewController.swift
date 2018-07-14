//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Cappillen on 7/5/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

// Createa tupe alias to refer to the FirebaseAuth.User type
typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Access the FUIAuth default auth UI singleton
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        // Set FUIAuth's singleton delegate
        authUI.delegate = self
        
        // Present the auth view controller
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    // Conform to the FUIAuthDelegate
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            // Crash the app with an error message so we know what's wrong
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = user else { return }
        
        UserService.show(forUID: user.uid, completion: { (user) in
            if let user = user {
                // Set the current user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initializeViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // If this is a new user make them create a username
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        })
        print("handle user signup / login")
    }
}
