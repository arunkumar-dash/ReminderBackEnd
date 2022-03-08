//
//  DeleteReminderDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol DeleteReminderDatabaseContract {
    func deleteReminder(username: String, reminder: Reminder, success: (Reminder) -> Void, failure: (String) -> Void)
}
