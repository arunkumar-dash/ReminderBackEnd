//
//  UpdateReminderDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 06/03/22.
//

import Foundation

public class UpdateReminderDataManager: UpdateReminderDataManagerContract {
    var database: UpdateReminderDatabaseContract
    
    public init(database: UpdateReminderDatabaseContract) {
        self.database = database
    }
    
    public func updateReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (UpdateReminderError) -> Void) {
        database.updateReminder(username: username, reminder: reminder, success: {
            [weak self]
            (reminder) in
            self?.success(reminder: reminder, callback: success)
        }, failure: {
            [weak self]
            (message) in
            self?.failure(message: message, callback: failure)
        })
    }
    
    private func success(reminder: Reminder, callback: (Reminder) -> Void) {
        callback(reminder)
    }
    
    private func failure(message: String, callback: (UpdateReminderError) -> Void) {
        if message == "Updation Failed" {
            let error = UpdateReminderError(status: .updationFailed)
            callback(error)
        } else if message == "Invalid Data" {
            let error = UpdateReminderError(status: .invalidData)
            callback(error)
        } else if message == "No Database Connection" {
            let error = UpdateReminderError(status: .noDatabaseConnection)
            callback(error)
        }
    }
}
