//
//  ChangePassword.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class ChangePasswordRequest {
    var username: String
    var password: String
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public final class ChangePasswordResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class ChangePasswordError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case updationFailed
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class ChangePassword {
    var dataManager: ChangePasswordDataManagerContract
    public init(dataManager: ChangePasswordDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: ChangePasswordRequest, success: @escaping (ChangePasswordResponse) -> Void, failure: @escaping (ChangePasswordError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.changePassword(username: request.username, password: request.password, success: {
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
    
    private func success(username: String, callback: @escaping (ChangePasswordResponse) -> Void) {
        let response = ChangePasswordResponse(username: username)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: ChangePasswordError, callback: @escaping (ChangePasswordError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
