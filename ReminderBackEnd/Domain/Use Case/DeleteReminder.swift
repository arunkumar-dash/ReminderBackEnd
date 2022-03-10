//
//  DeleteReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class DeleteReminderRequest: ZRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class DeleteReminderResponse: ZResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class DeleteReminderError: ZError {
}

public class DeleteReminder: ZUsecase<DeleteReminderRequest, DeleteReminderResponse, DeleteReminderError> {
    var dataManager: DeleteReminderDataManagerContract
    
    public init(dataManager: DeleteReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: DeleteReminderRequest, success: @escaping (DeleteReminderResponse) -> Void, failure: @escaping (DeleteReminderError) -> Void) {
        
        self.dataManager.deleteReminder(username: request.username, reminder: request.reminder, success: {
            [weak self]
            (reminder) in
            self?.success(reminder: reminder, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(reminder: Reminder, callback: @escaping (DeleteReminderResponse) -> Void) {
        let response = DeleteReminderResponse(reminder: reminder)
        
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: DeleteReminderError, callback: @escaping (DeleteReminderError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
