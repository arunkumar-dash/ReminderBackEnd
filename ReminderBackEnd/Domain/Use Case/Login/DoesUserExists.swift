//
//  DoesUserExists.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public final class DoesUserExistsRequest: ZRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class DoesUserExistsResponse: ZResponse {
    public var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class DoesUserExistsError: ZError {
    
}

public class DoesUserExists: ZUsecase<DoesUserExistsRequest, DoesUserExistsResponse, DoesUserExistsError> {
    var dataManager: DoesUserExistsDataManagerContract
    public init(dataManager: DoesUserExistsDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: DoesUserExistsRequest, success: @escaping (DoesUserExistsResponse) -> Void, failure: @escaping (DoesUserExistsError) -> Void) {
        self.dataManager.doesUserExists(username: request.username, success: {
            [weak self]
            (username) in
            self?.success(username: username, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(username: String, callback: @escaping (DoesUserExistsResponse) -> Void) {
        let response = DoesUserExistsResponse(username: username)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: DoesUserExistsError, callback: @escaping (DoesUserExistsError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
