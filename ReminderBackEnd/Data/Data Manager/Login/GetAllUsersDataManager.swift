//
//  GetAllUsersDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public class GetAllUsersDataManager: GetAllUsersDataManagerContract {
    var database: GetAllUsersDatabaseContract
    
    public init(database: GetAllUsersDatabaseContract) {
        self.database = database
    }
    
    public func getAllUsers(success: ([User]) -> Void, failure: (GetAllUsersError) -> Void) {
        database.getAllUsers(success: {
            [weak self]
            (users) in
            self?.success(users: users, callback: success)
        }, failure: {
            [weak self]
            (message) in
            self?.failure(message: message, callback: failure)
        })
    }
    
    private func success(users: [User], callback: ([User]) -> Void) {
        callback(users)
    }
    
    private func failure(message: String, callback: (GetAllUsersError) -> Void) {
        if message == "No Database Connection" {
            let error = GetAllUsersError(status: .noDatabaseConnection)
            callback(error)
        } else if message == "No User Found" {
            let error = GetAllUsersError(status: .noUserFound)
            callback(error)
        }
    }
}
