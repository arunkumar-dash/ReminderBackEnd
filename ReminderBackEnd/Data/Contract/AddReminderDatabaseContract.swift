//
//  AddReminderDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol AddReminderDatabaseContract {
    func addReminder(username: String, reminder: Reminder, success: (Reminder) -> Void, failure: (String) -> Void)
}
