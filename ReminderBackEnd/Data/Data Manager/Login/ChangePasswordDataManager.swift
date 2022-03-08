//
//  ChangePasswordDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class ChangePasswordDataManager: ChangePasswordDataManagerContract {
    var database: ChangePasswordDatabaseContract
    
    public init(database: ChangePasswordDatabaseContract) {
        self.database = database
    }
    
    public func changePassword(username: String, password: String, success: (String) -> Void, failure: (ChangePasswordError) -> Void) {
        database.changePassword(username: username, password: password, success: {
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
    
    private func failure(message: String, callback: (ChangePasswordError) -> Void) {
        if message == "No Database Connection" {
            let error = ChangePasswordError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "Updation Failed" {
            let error = ChangePasswordError(status: .updationFailed)
            callback(error)
        }
    }
}
