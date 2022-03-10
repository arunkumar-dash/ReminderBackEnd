//
//  CreateUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class CreateUserRequest: ZRequest {
    var username: String
    var password: String
    var imageURL: URL?
    public init(username: String, password: String, imageURL: URL?) {
        self.username = username
        self.password = password
        self.imageURL = imageURL
    }
}

public final class CreateUserResponse: ZResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class CreateUserError: ZError {
    
}

public class CreateUser: ZUsecase<CreateUserRequest, CreateUserResponse, CreateUserError> {
    var dataManager: CreateUserDataManagerContract
    public init(dataManager: CreateUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: CreateUserRequest, success: @escaping (CreateUserResponse) -> Void, failure: @escaping (CreateUserError) -> Void) {
        self.dataManager.createUser(username: request.username, password: request.password, imageURL: request.imageURL, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(username: String, callback: @escaping (CreateUserResponse) -> Void) {
        let response = CreateUserResponse(username: username)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: CreateUserError, callback: @escaping (CreateUserError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
