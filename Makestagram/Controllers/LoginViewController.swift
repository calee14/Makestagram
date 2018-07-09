//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Cappillen on 7/5/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("Login Button Tapped")
    }
}
