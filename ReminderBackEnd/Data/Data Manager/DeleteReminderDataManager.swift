//
//  DeleteReminderDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 06/03/22.
//

import Foundation

public class DeleteReminderDataManager: DeleteReminderDataManagerContract {
    var database: DeleteReminderDatabaseContract
    
    public init(database: DeleteReminderDatabaseContract) {
        self.database = database
    }
    
    public func deleteReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (DeleteReminderError) -> Void) {
        database.deleteReminder(username: username, reminder: reminder, success: {
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
    
    private func failure(message: String, callback: (DeleteReminderError) -> Void) {
        if message == "Deletion Failed" {
            let error = DeleteReminderError(status: .deletionFailed)
            callback(error)
        } else if message == "Invalid Data" {
            let error = DeleteReminderError(status: .invalidData)
            callback(error)
        } else if message == "No Database Connection" {
            let error = DeleteReminderError(status: .noDatabaseConnection)
            callback(error)
        }
    }
}
