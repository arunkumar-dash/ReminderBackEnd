//
//  SetLastLoggedInUserDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public class SetLastLoggedInUserDataManager: SetLastLoggedInUserDataManagerContract {
    var database: SetLastLoggedInUserDatabaseContract
    
    public init(database: SetLastLoggedInUserDatabaseContract) {
        self.database = database
    }
    
    public func setLastLoggedInUser(user: User, success: (User) -> Void, failure: (SetLastLoggedInUserError) -> Void) {
        database.setLastLoggedInUser(user: user, success: {
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
    
    private func failure(message: String, callback: (SetLastLoggedInUserError) -> Void) {
        if message == "No Database Connection" {
            let error = SetLastLoggedInUserError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "Updation Failed" {
            let error = SetLastLoggedInUserError(status: .updationFailed)
            callback(error)
        }
    }
}
