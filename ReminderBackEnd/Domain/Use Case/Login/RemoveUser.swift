//
//  RemoveUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class RemoveUserRequest: ZRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class RemoveUserResponse: ZResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class RemoveUserError: ZError {
}

public class RemoveUser: ZUsecase<RemoveUserRequest, RemoveUserResponse, RemoveUserError> {
    var dataManager: RemoveUserDataManagerContract
    public init(dataManager: RemoveUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: RemoveUserRequest, success: @escaping (RemoveUserResponse) -> Void, failure: @escaping (RemoveUserError) -> Void) {
        dataManager.removeUser(username: request.username, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(username: String, callback: @escaping (RemoveUserResponse) -> Void) {
        let response = RemoveUserResponse(username: username)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: RemoveUserError, callback: @escaping (RemoveUserError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
