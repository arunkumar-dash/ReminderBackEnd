//
//  SetLastLoggedInUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class SetLastLoggedInUserRequest {
    var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class SetLastLoggedInUserResponse {
    public var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class SetLastLoggedInUserError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case updationFailed
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class SetLastLoggedInUser {
    var dataManager: SetLastLoggedInUserDataManagerContract
    public init(dataManager: SetLastLoggedInUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: SetLastLoggedInUserRequest, success: @escaping (SetLastLoggedInUserResponse) -> Void, failure: @escaping (SetLastLoggedInUserError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.setLastLoggedInUser(user: request.user, success: {
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
    
    private func success(user: User, callback: @escaping (SetLastLoggedInUserResponse) -> Void) {
        let response = SetLastLoggedInUserResponse(user: user)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: SetLastLoggedInUserError, callback: @escaping (SetLastLoggedInUserError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
