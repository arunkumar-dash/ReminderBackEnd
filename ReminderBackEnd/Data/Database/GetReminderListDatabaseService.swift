//
//  GetReminderListDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class GetReminderListDatabaseService: GetReminderListDatabaseContract {
    public init() {
        
    }
    
    public func getReminderList(username: String, success: ([Reminder]) -> Void, failure: (String) -> Void) {
        let reminderDatabase = ReminderDatabase(for: username)
        let optionalReminders = reminderDatabase.getAllRows()
        var reminders: [Reminder] = []
        for reminder in optionalReminders {
            if let reminder = reminder {
                reminders.append(reminder)
            }
        }
        if reminders.count > 0 {
            success(reminders)
        } else {
            failure("No Data")
        }
    }
}
