//
//  DeleteReminderDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public protocol DeleteReminderDataManagerContract {
    func deleteReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (DeleteReminderError) -> Void)
}
