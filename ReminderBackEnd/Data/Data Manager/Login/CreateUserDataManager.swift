//
//  CreateUserDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class CreateUserDataManager: CreateUserDataManagerContract {
    var database: CreateUserDatabaseContract
    
    public init(database: CreateUserDatabaseContract) {
        self.database = database
    }
    
    public func createUser(username: String, password: String, imageURL: URL?, success: (String) -> Void, failure: (CreateUserError) -> Void) {
        database.createUser(username: username, password: password, imageURL: imageURL, success: {
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
    
    private func failure(message: String, callback: (CreateUserError) -> Void) {
        if message == "No Database Connection" {
            let error = CreateUserError(status: .networkUnavailable)
            callback(error)
        } else if message == "Creation Failed" {
            let error = CreateUserError(status: .unknownError)
            callback(error)
        } else if message == "User Already Exists" {
            let error = CreateUserError(status: .unknownError)
            callback(error)
        }
    }
}
