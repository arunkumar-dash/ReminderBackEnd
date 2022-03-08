//
//  UpdateReminderDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public protocol UpdateReminderDataManagerContract {
    func updateReminder(username: String, reminder: Reminder, success: @escaping (Reminder) -> Void, failure: @escaping (UpdateReminderError) -> Void)
}
