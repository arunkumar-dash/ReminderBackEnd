//
//  GetLastLoggedInUserDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public class GetLastLoggedInUserDataManager: GetLastLoggedInUserDataManagerContract {
    var database: GetLastLoggedInUserDatabaseContract
    
    public init(database: GetLastLoggedInUserDatabaseContract) {
        self.database = database
    }
    
    public func getLastLoggedInUser(success: (User) -> Void, failure: (GetLastLoggedInUserError) -> Void) {
        database.getLastLoggedInUser(success: {
            [weak self]
            (user) in
            self?.success(user: user, callback: success)
        }, failure: {
            [weak self]
            (message) in
            self?.failure(message: message, callback: failure)
        })
    }
    
    private func success(user: User, callback: (User) -> Void) {
        callback(user)
    }
    
    private func failure(message: String, callback: (GetLastLoggedInUserError) -> Void) {
        if message == "No Database Connection" {
            let error = GetLastLoggedInUserError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "No User Found" {
            let error = GetLastLoggedInUserError(status: .noUserFound)
            callback(error)
        }
    }
}
