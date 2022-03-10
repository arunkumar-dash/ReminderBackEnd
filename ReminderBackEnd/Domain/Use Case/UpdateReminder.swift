//
//  UpdateReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation


public final class UpdateReminderRequest: ZRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class UpdateReminderResponse: ZResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class UpdateReminderError: ZError {
    
}

public class UpdateReminder: ZUsecase<UpdateReminderRequest, UpdateReminderResponse, UpdateReminderError> {
    var dataManager: UpdateReminderDataManagerContract
    
    public init(dataManager: UpdateReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: UpdateReminderRequest, success: @escaping (UpdateReminderResponse) -> Void, failure:  @escaping (UpdateReminderError) -> Void) {
        self.dataManager.updateReminder(username: request.username, reminder: request.reminder, success: {
            [weak self]
            (reminder) in
            self?.success(reminder: reminder, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(reminder: Reminder, callback: @escaping (UpdateReminderResponse) -> Void) {
        let response = UpdateReminderResponse(reminder: reminder)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: UpdateReminderError, callback: @escaping (UpdateReminderError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
