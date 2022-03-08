//
//  DoesUserExistsDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class DoesUserExistsDataManager: DoesUserExistsDataManagerContract {
    var database: DoesUserExistsDatabaseContract
    
    public init(database: DoesUserExistsDatabaseContract) {
        self.database = database
    }
    
    public func doesUserExists(username: String, success: (String) -> Void, failure: (DoesUserExistsError) -> Void) {
        database.doesUserExists(username: username, success: {
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
    
    private func failure(message: String, callback: (DoesUserExistsError) -> Void) {
        if message == "No Database Connection" {
            let error = DoesUserExistsError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "User Does Not Exists" {
            let error = DoesUserExistsError(status: .userDoesNotExists)
            callback(error)
        }
    }
}
