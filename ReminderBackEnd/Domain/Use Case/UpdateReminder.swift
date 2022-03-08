//
//  UpdateReminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation


public final class UpdateReminderRequest {
    var username: String
    var reminder: Reminder
    public init(username: String, reminder: Reminder) {
        self.username = username
        self.reminder = reminder
    }
}

public final class UpdateReminderResponse {
    public var reminder: Reminder
    public init(reminder: Reminder) {
        self.reminder = reminder
    }
}

public final class UpdateReminderError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case updationFailed
        case invalidData
    }
    
    public init(status: Status) {
        self.status = status
    }
}

public class UpdateReminder {
    var dataManager: UpdateReminderDataManagerContract
    
    public init(dataManager: UpdateReminderDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: UpdateReminderRequest, success: @escaping (UpdateReminderResponse) -> Void, failure:  @escaping (UpdateReminderError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.updateReminder(username: request.username, reminder: request.reminder, success: {
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
    
    private func success(reminder: Reminder, callback: @escaping (UpdateReminderResponse) -> Void) {
        let response = UpdateReminderResponse(reminder: reminder)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: UpdateReminderError, callback: @escaping (UpdateReminderError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
