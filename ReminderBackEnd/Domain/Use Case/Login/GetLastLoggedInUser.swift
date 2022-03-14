//
//  GetLastLoggedInUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class GetLastLoggedInUserRequest: ZRequest {
    public override init() {
        
    }
}

public final class GetLastLoggedInUserResponse: ZResponse {
    public var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class GetLastLoggedInUserError: ZError {
}

public class GetLastLoggedInUser: ZUsecase<GetLastLoggedInUserRequest, GetLastLoggedInUserResponse, GetLastLoggedInUserError> {
    var dataManager: GetLastLoggedInUserDataManagerContract
    public init(dataManager: GetLastLoggedInUserDataManagerContract) {
        self.dataManager = dataManager
    }
    deinit {
    }
    
    public override func run(request: GetLastLoggedInUserRequest, success: @escaping (GetLastLoggedInUserResponse) -> Void, failure: @escaping (GetLastLoggedInUserError) -> Void) {
        self.dataManager.getLastLoggedInUser(success: {
            [weak self]
            (user) in
            self?.success(user: user, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(user: User, callback: @escaping (GetLastLoggedInUserResponse) -> Void) {
        let response = GetLastLoggedInUserResponse(user: user)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: GetLastLoggedInUserError, callback: @escaping (GetLastLoggedInUserError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
