//
//  GetReminderList.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class GetReminderListRequest: ZRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class GetReminderListResponse: ZResponse {
    public var reminders: [Reminder]
    public init(reminders: [Reminder]) {
        self.reminders = reminders
    }
}

public final class GetReminderListError: ZError {
}

public class GetReminderList: ZUsecase<GetReminderListRequest, GetReminderListResponse, GetReminderListError> {
    var dataManager: GetReminderListDataManagerContract
    
    public init(dataManager: GetReminderListDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetReminderListRequest, success: @escaping (GetReminderListResponse) -> Void, failure:  @escaping (GetReminderListError) -> Void) {
        self.dataManager.getReminderList(username: request.username, success: {
            [weak self]
            (reminders) in
            self?.success(reminders: reminders, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(reminders: [Reminder], callback: @escaping (GetReminderListResponse) -> Void) {
        let response = GetReminderListResponse(reminders: reminders)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: GetReminderListError, callback: @escaping (GetReminderListError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
