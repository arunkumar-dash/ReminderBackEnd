//
//  RemoveUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class RemoveUserRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class RemoveUserResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class RemoveUserError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case deletionFailed
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class RemoveUser {
    var dataManager: RemoveUserDataManagerContract
    public init(dataManager: RemoveUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: RemoveUserRequest, success: @escaping (RemoveUserResponse) -> Void, failure: @escaping (RemoveUserError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.removeUser(username: request.username, success: {
                [weak self]
                (username) in
                self?.success(username: username, callback: success)
            }, failure: {
                [weak self]
                (error) in
                self?.failure(error: error, callback: failure)
            })
        }
    }
    
    private func success(username: String, callback: @escaping (RemoveUserResponse) -> Void) {
        let response = RemoveUserResponse(username: username)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: RemoveUserError, callback: @escaping (RemoveUserError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
