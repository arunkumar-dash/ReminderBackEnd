//
//  DoesUserExistsDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class DoesUserExistsDatabaseService: DoesUserExistsDatabaseContract {
    public init() {
        
    }
    
    public func doesUserExists(username: String, success: (String) -> Void, failure: (String) -> Void) {
        let credentialsDB = UserDatabase()
        if let _ = credentialsDB.getPassword(forUsername: username) {
            success(username)
        } else {
            failure("User Does Not Exists")
        }
    }
}
