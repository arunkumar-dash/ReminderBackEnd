//
//  GetReminderListDataManager.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public class GetReminderListDataManager: GetReminderListDataManagerContract {
    var database: GetReminderListDatabaseContract
    
    public init(database: GetReminderListDatabaseContract) {
        self.database = database
    }
    
    public func getReminderList(username: String, success: ([Reminder]) -> Void, failure: (GetReminderListError) -> Void) {
        // fetch from db, if success, call success, else call failure
        database.getReminderList(username: username, success: {
            [weak self]
            (reminders) in
            self?.success(reminders: reminders, callback: success)
        }, failure: {
            [weak self]
            (message) in
            self?.failure(message: message, callback: failure)
        })
    }
    
    private func success(reminders: [Reminder], callback: ([Reminder]) -> Void) {
        callback(reminders)
    }
    
    private func failure(message: String, callback: (GetReminderListError) -> Void) {
        if message == "No Data" {
            let error = GetReminderListError(status: .noDataFound)
            callback(error)
        } else if message == "No Database Connection" {
            let error = GetReminderListError(status: .noDatabaseConnection)
            callback(error)
        }
    }
}
