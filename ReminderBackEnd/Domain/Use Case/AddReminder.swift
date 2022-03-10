//
//  AddReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class AddReminderRequest: ZRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class AddReminderResponse: ZResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class AddReminderError: ZError {
}

public class AddReminder: ZUsecase<AddReminderRequest, AddReminderResponse, AddReminderError> {
    var dataManager: AddReminderDataManagerContract
    public init(dataManager: AddReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddReminderRequest, success: @escaping (AddReminderResponse) -> Void, failure: @escaping (AddReminderError) -> Void) {
        self.dataManager.addReminder(username: request.username, reminder: request.reminder, success: {
            [weak self]
            (reminder) in
            self?.success(reminder: reminder, callback: success)
        }, failure: {
            [weak self]
            (error) in
            self?.failure(error: error, callback: failure)
        })
    }
    
    private func success(reminder: Reminder, callback: @escaping (AddReminderResponse) -> Void) {
        let response = AddReminderResponse(reminder: reminder)
        invokeSuccess(callback: callback, response: response)
    }
    
    private func failure(error: AddReminderError, callback: @escaping (AddReminderError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
