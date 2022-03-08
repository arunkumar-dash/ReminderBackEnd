//
//  IsCorrectPasswordDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class IsCorrectPasswordDatabaseService: IsCorrectPasswordDatabaseContract {
    public init() {
        
    }
    
    public func isCorrectPassword(username: String, password: String, success: (String) -> Void, failure: (String) -> Void) {
        let credentialsDB = UserDatabase()
        if let passwordFromDB = credentialsDB.getPassword(forUsername: username) {
            if passwordFromDB == password {
                success(username)
            } else {
                failure("Password Incorrect")
            }
        } else {
            failure("User Name Not Found")
        }
    }
}
