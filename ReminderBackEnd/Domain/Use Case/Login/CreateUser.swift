//
//  CreateUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class CreateUserRequest {
    var username: String
    var password: String
    var imageURL: URL?
    public init(username: String, password: String, imageURL: URL?) {
        self.username = username
        self.password = password
        self.imageURL = imageURL
    }
}

public final class CreateUserResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class CreateUserError {
    public var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case creationFailed
        case userAlreadyExists
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class CreateUser {
    var dataManager: CreateUserDataManagerContract
    public init(dataManager: CreateUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: CreateUserRequest, success: @escaping (CreateUserResponse) -> Void, failure: @escaping (CreateUserError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.createUser(username: request.username, password: request.password, imageURL: request.imageURL, success: {
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
    
    private func success(username: String, callback: @escaping (CreateUserResponse) -> Void) {
        let response = CreateUserResponse(username: username)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: CreateUserError, callback: @escaping (CreateUserError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
