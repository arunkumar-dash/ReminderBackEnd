//
//  GetReminderListDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol GetReminderListDatabaseContract {
    func getReminderList(username: String, success: ([Reminder]) -> Void, failure: (String) -> Void)
}
