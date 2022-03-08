//
//  ChangePasswordDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class ChangePasswordDatabaseService: ChangePasswordDatabaseContract {
    public init() {
        
    }
    public func changePassword(username: String, password: String, success: (String) -> Void, failure: (String) -> Void) {
        let credentialsDB = UserDatabase()
        if credentialsDB.update(password: password, for: username) {
            success(username)
        } else {
            failure("Updation Failed")
        }
    }
}
