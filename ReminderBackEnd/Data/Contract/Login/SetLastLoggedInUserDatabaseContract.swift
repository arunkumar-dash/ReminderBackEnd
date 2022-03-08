//
//  SetLastLoggedInUserDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public protocol SetLastLoggedInUserDatabaseContract {
    func setLastLoggedInUser(user: User, success: (User) -> Void, failure: (String) -> Void)
}
