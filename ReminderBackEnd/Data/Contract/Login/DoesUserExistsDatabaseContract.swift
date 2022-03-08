//
//  DoesUserExistsDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol DoesUserExistsDatabaseContract {
    func doesUserExists(username: String, success: (String) -> Void, failure: (String) -> Void)
}
