//
//  GetLastLoggedInUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class GetLastLoggedInUserRequest {
    public init() {
        
    }
}

public final class GetLastLoggedInUserResponse {
    public var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class GetLastLoggedInUserError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case noUserFound
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class GetLastLoggedInUser {
    var dataManager: GetLastLoggedInUserDataManagerContract
    public init(dataManager: GetLastLoggedInUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: GetLastLoggedInUserRequest, success: @escaping (GetLastLoggedInUserResponse) -> Void, failure: @escaping (GetLastLoggedInUserError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.getLastLoggedInUser(success: {
                [weak self]
                (user) in
                self?.success(user: user, callback: success)
            }, failure: {
                [weak self]
                (error) in
                self?.failure(error: error, callback: failure)
            })
        }
    }
    
    private func success(user: User, callback: @escaping (GetLastLoggedInUserResponse) -> Void) {
        let response = GetLastLoggedInUserResponse(user: user)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: GetLastLoggedInUserError, callback: @escaping (GetLastLoggedInUserError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
