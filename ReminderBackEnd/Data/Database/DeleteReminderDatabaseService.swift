//
//  DeleteReminderDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class DeleteReminderDatabaseService: DeleteReminderDatabaseContract {
    public init() {
        
    }
    
    public func deleteReminder(username: String, reminder: Reminder, success: (Reminder) -> Void, failure: (String) -> Void) {
        let reminderDatabase = ReminderDatabase(for: username)
        var failureMessage = ""
        if let id = reminder.id {
            if reminderDatabase.delete(id: id) {
                success(reminder)
            } else {
                failureMessage = "Deletion Failed"
                failure(failureMessage)
            }
        } else {
            failureMessage = "Invalid Data"
            failure(failureMessage)
        }
    }
}
