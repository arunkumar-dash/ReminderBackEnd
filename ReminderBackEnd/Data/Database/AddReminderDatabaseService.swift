//
//  AddReminderDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class AddReminderDatabaseService: AddReminderDatabaseContract {
    public init() {
        
    }
    
    public func addReminder(username: String, reminder: Reminder, success: (Reminder) -> Void, failure: (String) -> Void) {
        let reminderDatabase = ReminderDatabase(for: username)
        if reminderDatabase.create(element: reminder) {
            success(reminder)
        } else {
            failure("Addition Failed")
        }
    }
}
