//
//  GetAllUsersDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class GetAllUsersDatabaseService: GetAllUsersDatabaseContract {
    public init() {
        
    }
    
    public func getAllUsers(success: ([User]) -> Void, failure: (String) -> Void) {
        let credentialsDatabase = UserDatabase()
        let allUsers = credentialsDatabase.getAllUsers()
        if allUsers.count > 0 {
            success(allUsers)
        } else {
            failure("No User Found")
        }
    }
}
