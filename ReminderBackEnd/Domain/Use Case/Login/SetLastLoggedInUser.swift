//
//  SetLastLoggedInUser.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class SetLastLoggedInUserRequest: ZRequest {
    var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class SetLastLoggedInUserResponse: ZResponse {
    public var user: User
    public init(user: User) {
        self.user = user
    }
}

public final class SetLastLoggedInUserError: ZError {
}

public class SetLastLoggedInUser: ZUsecase<SetLastLoggedInUserRequest, SetLastLoggedInUserResponse, SetLastLoggedInUserError> {
    var dataManager: SetLastLoggedInUserDataManagerContract
    public init(dataManager: SetLastLoggedInUserDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: SetLastLoggedInUserRequest, success: @escaping (SetLastLoggedInUserResponse) -> Void, failure: @escaping (SetLastLoggedInUserError) -> Void) {
        dataManager.setLastLoggedInUser(user: request.user, success: {
            [weak self]
            (user) in
            self?.success(user: user, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(user: User, callback: @escaping (SetLastLoggedInUserResponse) -> Void) {
        let response = SetLastLoggedInUserResponse(user: user)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: SetLastLoggedInUserError, callback: @escaping (SetLastLoggedInUserError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
