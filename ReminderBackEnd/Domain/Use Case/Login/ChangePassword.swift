//
//  ChangePassword.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class ChangePasswordRequest: ZRequest {
    var username: String
    var password: String
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public final class ChangePasswordResponse: ZResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class ChangePasswordError: ZError {
    
}

public class ChangePassword: ZUsecase<ChangePasswordRequest, ChangePasswordResponse, ChangePasswordError> {
    var dataManager: ChangePasswordDataManagerContract
    public init(dataManager: ChangePasswordDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: ChangePasswordRequest, success: @escaping (ChangePasswordResponse) -> Void, failure: @escaping (ChangePasswordError) -> Void) {
        
        self.dataManager.changePassword(username: request.username, password: request.password, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(username: String, callback: @escaping (ChangePasswordResponse) -> Void) {
        let response = ChangePasswordResponse(username: username)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: ChangePasswordError, callback: @escaping (ChangePasswordError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
