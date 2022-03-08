//
//  RemoveUserDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class RemoveUserDataManager: RemoveUserDataManagerContract {
    var database: RemoveUserDatabaseContract
    
    public init(database: RemoveUserDatabaseContract) {
        self.database = database
    }
    
    public func removeUser(username: String, success: (String) -> Void, failure: (RemoveUserError) -> Void) {
        database.removeUser(username: username, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (message) in
            self?.failure(message: message, callback: failure)
        })
    }
    
    private func success(username: String, callback: (String) -> Void) {
        callback(username)
    }
    
    private func failure(message: String, callback: (RemoveUserError) -> Void) {
        if message == "No Database Connection" {
            let error = RemoveUserError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "Deletion Failed" {
            let error = RemoveUserError(status: .deletionFailed)
            callback(error)
        }
    }
}
