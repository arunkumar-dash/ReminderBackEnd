//
//  IsCorrectPasswordDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol IsCorrectPasswordDatabaseContract {
    func isCorrectPassword(username: String, password: String, success: (String) -> Void, failure: (String) -> Void)
}
