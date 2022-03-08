//
//  AddReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class AddReminderRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class AddReminderResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class AddReminderError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case additionFailed
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class AddReminder {
    var dataManager: AddReminderDataManagerContract
    public init(dataManager: AddReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: AddReminderRequest, success: @escaping (AddReminderResponse) -> Void, failure: @escaping (AddReminderError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.addReminder(username: request.username, reminder: request.reminder, success: {
                [weak self]
                (reminder) in
                self?.success(reminder: reminder, callback: success)
            }, failure: {
                [weak self]
                (error) in
                self?.failure(error: error, callback: failure)
            })
        }
    }
    
    private func success(reminder: Reminder, callback: @escaping (AddReminderResponse) -> Void) {
        let response = AddReminderResponse(reminder: reminder)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: AddReminderError, callback: @escaping (AddReminderError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
