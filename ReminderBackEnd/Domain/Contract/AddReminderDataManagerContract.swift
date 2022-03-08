//
//  AddReminderDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public protocol AddReminderDataManagerContract {
    func addReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (AddReminderError) -> Void)
}
