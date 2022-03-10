//
//  GetAllUsers.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class GetAllUsersRequest: ZRequest {
    public override init() {
        
    }
}

public final class GetAllUsersResponse: ZResponse {
    public var users: [User]
    public init(users: [User]) {
        self.users = users
    }
}

public final class GetAllUsersError: ZError {
}

public class GetAllUsers: ZUsecase<GetAllUsersRequest, GetAllUsersResponse, GetAllUsersError> {
    var dataManager: GetAllUsersDataManagerContract
    public init(dataManager: GetAllUsersDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetAllUsersRequest, success: @escaping (GetAllUsersResponse) -> Void, failure: @escaping (GetAllUsersError) -> Void) {
        self.dataManager.getAllUsers(success: {
            [weak self]
            (users) in
            self?.success(users: users, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
        
    }
    
    private func success(users: [User], callback: @escaping (GetAllUsersResponse) -> Void) {
        let response = GetAllUsersResponse(users: users)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: GetAllUsersError, callback: @escaping (GetAllUsersError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
