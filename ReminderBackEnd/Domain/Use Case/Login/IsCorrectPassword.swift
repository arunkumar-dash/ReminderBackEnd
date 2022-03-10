//
//  IsCorrectPassword.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class IsCorrectPasswordRequest: ZRequest {
    var username: String
    var password: String
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public final class IsCorrectPasswordResponse: ZResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class IsCorrectPasswordError: ZError {
    
}

public class IsCorrectPassword: ZUsecase<IsCorrectPasswordRequest, IsCorrectPasswordResponse, IsCorrectPasswordError> {
    var dataManager: IsCorrectPasswordDataManagerContract
    public init(dataManager: IsCorrectPasswordDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: IsCorrectPasswordRequest, success: @escaping (IsCorrectPasswordResponse) -> Void, failure: @escaping (IsCorrectPasswordError) -> Void) {
        
        self.dataManager.isCorrectPassword(username: request.username, password: request.password, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(username: String, callback: @escaping (IsCorrectPasswordResponse) -> Void) {
        let response = IsCorrectPasswordResponse(username: username)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: IsCorrectPasswordError, callback: @escaping (IsCorrectPasswordError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
