//
//  User.swift
//  Makestagram
//
//  Created by Cappillen on 7/9/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

// Implement the Codable protocol so the user object can properly be encoded as Data and stored in UserDefaults
class User: Codable {
    
    // MARK: Properties
    
    let uid: String
    let username: String
    
    // Create a private static variable to hold the current user
    private static var _current: User?
    
    var isFollowed = false
    
    // Create a computer variable that only has a getter that can access the private _current variable
    static var current: User {
        // If _current isn't nil it will be returned
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    }
    
    // MARK: - Init
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    // Create a failable Initializer
    
    init?(snapshot: DataSnapshot) {
        
        // Requiring the snapshot to be casted to a dictionay
        // Check if the snapshot contains a username
        // If fails we return nil
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String
            else { return nil }
        // Set the properties to the user
        self.uid = snapshot.key
        self.username = username
        
    }
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // Write the user to user defaults
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        // Set the current user
        _current = user
    }
}
