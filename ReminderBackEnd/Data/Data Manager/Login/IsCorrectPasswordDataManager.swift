//
//  IsCorrectPasswordDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class IsCorrectPasswordDataManager: IsCorrectPasswordDataManagerContract {
    var database: IsCorrectPasswordDatabaseContract
    
    public init(database: IsCorrectPasswordDatabaseContract) {
        self.database = database
    }
    
    public func isCorrectPassword(username: String, password: String, success: (String) -> Void, failure: (IsCorrectPasswordError) -> Void) {
        database.isCorrectPassword(username: username, password: password, success: {
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
    
    private func failure(message: String, callback: (IsCorrectPasswordError) -> Void) {
        if message == "No Database Connection" {
            let error = IsCorrectPasswordError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "User Name Not Found" {
            let error = IsCorrectPasswordError(status: .userNameNotFound)
            callback(error)
        } else if message == "Password Incorrect" {
            let error = IsCorrectPasswordError(status: .passwordIncorrect)
            callback(error)
        }
    }
}
