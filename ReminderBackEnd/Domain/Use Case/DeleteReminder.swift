//
//  DeleteReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class DeleteReminderRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class DeleteReminderResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class DeleteReminderError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case deletionFailed
        case invalidData
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class DeleteReminder {
    var dataManager: DeleteReminderDataManagerContract
    
    public init(dataManager: DeleteReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: DeleteReminderRequest, success: @escaping (DeleteReminderResponse) -> Void, failure: @escaping (DeleteReminderError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.deleteReminder(username: request.username, reminder: request.reminder, success: {
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
    
    private func success(reminder: Reminder, callback: @escaping (DeleteReminderResponse) -> Void) {
        let response = DeleteReminderResponse(reminder: reminder)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: DeleteReminderError, callback: @escaping (DeleteReminderError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
