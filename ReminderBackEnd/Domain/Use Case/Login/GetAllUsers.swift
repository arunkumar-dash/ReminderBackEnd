//
//  GetAllUsers.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class GetAllUsersRequest {
    public init() {
        
    }
}

public final class GetAllUsersResponse {
    public var users: [User]
    public init(users: [User]) {
        self.users = users
    }
}

public final class GetAllUsersError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case noUserFound
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class GetAllUsers {
    var dataManager: GetAllUsersDataManagerContract
    public init(dataManager: GetAllUsersDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: GetAllUsersRequest, success: @escaping (GetAllUsersResponse) -> Void, failure: @escaping (GetAllUsersError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.getAllUsers(success: {
                [weak self]
                (users) in
                self?.success(users: users, callback: success)
            }, failure: {
                [weak self]
                (error) in
                self?.failure(error: error, callback: failure)
            })
        }
    }
    
    private func success(users: [User], callback: @escaping (GetAllUsersResponse) -> Void) {
        let response = GetAllUsersResponse(users: users)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: GetAllUsersError, callback: @escaping (GetAllUsersError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
