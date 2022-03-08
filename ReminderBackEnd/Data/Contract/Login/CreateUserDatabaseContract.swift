//
//  CreateUserDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol CreateUserDatabaseContract {
    func createUser(username: String, password: String, imageURL: URL?, success: (String) -> Void, failure: (String) -> Void)
}
