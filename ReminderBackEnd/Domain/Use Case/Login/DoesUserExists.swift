//
//  DoesUserExists.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class DoesUserExistsRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class DoesUserExistsResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class DoesUserExistsError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case userDoesNotExists
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class DoesUserExists {
    var dataManager: DoesUserExistsDataManagerContract
    public init(dataManager: DoesUserExistsDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: DoesUserExistsRequest, success: @escaping (DoesUserExistsResponse) -> Void, failure: @escaping (DoesUserExistsError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.doesUserExists(username: request.username, success: {
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
    
    private func success(username: String, callback: @escaping (DoesUserExistsResponse) -> Void) {
        let response = DoesUserExistsResponse(username: username)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: DoesUserExistsError, callback: @escaping (DoesUserExistsError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
