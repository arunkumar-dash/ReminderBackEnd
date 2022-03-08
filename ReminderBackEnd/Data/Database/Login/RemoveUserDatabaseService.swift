//
//  RemoveUserDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class RemoveUserDatabaseService: RemoveUserDatabaseContract {
    public init() {
        
    }
    
    public func removeUser(username: String, success: (String) -> Void, failure: (String) -> Void) {
        let credentialsDB = UserDatabase()
        if credentialsDB.delete(username: username) {
            success(username)
        } else {
            failure("Deletion Failed")
        }
    }
}
