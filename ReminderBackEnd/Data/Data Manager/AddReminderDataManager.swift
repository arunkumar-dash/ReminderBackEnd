//
//  AddReminderDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 06/03/22.
//

import Foundation

public class AddReminderDataManager: AddReminderDataManagerContract {
    var database: AddReminderDatabaseContract
    
    public init(database: AddReminderDatabaseContract) {
        self.database = database
    }
    
    public func addReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (AddReminderError) -> Void) {
        database.addReminder(username: username, reminder: reminder, success: {
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
    
    private func failure(message: String, callback: (AddReminderError) -> Void) {
        if message == "Addition Failed" {
            let error = AddReminderError(status: .additionFailed)
            callback(error)
        } else if message == "No Database Connection" {
            let error = AddReminderError(status: .noDatabaseConnection)
            callback(error)
        }
    }
}
