//
//  GetLastLoggedInUserDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public protocol GetLastLoggedInUserDatabaseContract {
    func getLastLoggedInUser(success: (User) -> Void, failure: (String) -> Void)
}
