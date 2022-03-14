//
//  UpdateReminderDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class UpdateReminderDatabaseService: UpdateReminderDatabaseContract {
    public init() {
        
    }
    
    public func updateReminder(username: String, reminder: Reminder, success: (Reminder) -> Void, failure: (String) -> Void) {
        let reminderDatabase = ReminderDatabase(for: username)
        if let id = reminder.id {
            if reminderDatabase.update(id: id, element: reminder) {
                success(reminder)
            } else {
                failure("Updation Failed")
            }
        } else {
            failure("Invalid Data")
        }
    }
}
