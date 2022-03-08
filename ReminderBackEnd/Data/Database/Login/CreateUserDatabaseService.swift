//
//  CreateUserDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class CreateUserDatabaseService: CreateUserDatabaseContract {
    public init() {
        
    }
    public func createUser(username: String, password: String, imageURL: URL?, success: (String) -> Void, failure: (String) -> Void) {
        let credentialsDB = UserDatabase()
        if let _ = credentialsDB.getPassword(forUsername: username) {
            failure("User Already Exists")
        } else if credentialsDB.insert(username: username, password: password, imageURL: imageURL) {
            success(username)
        } else {
            failure("Creation Failed")
        }
    }
}
