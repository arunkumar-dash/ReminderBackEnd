//
//  IsCorrectPassword.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class IsCorrectPasswordRequest {
    var username: String
    var password: String
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public final class IsCorrectPasswordResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class IsCorrectPasswordError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case userNameNotFound
        case passwordIncorrect
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class IsCorrectPassword {
    var dataManager: IsCorrectPasswordDataManagerContract
    public init(dataManager: IsCorrectPasswordDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: IsCorrectPasswordRequest, success: @escaping (IsCorrectPasswordResponse) -> Void, failure: @escaping (IsCorrectPasswordError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.isCorrectPassword(username: request.username, password: request.password, success: {
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
    
    private func success(username: String, callback: @escaping (IsCorrectPasswordResponse) -> Void) {
        let response = IsCorrectPasswordResponse(username: username)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: IsCorrectPasswordError, callback: @escaping (IsCorrectPasswordError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
