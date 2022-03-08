//
//  GetLastLoggedInUserDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public protocol GetLastLoggedInUserDataManagerContract {
    func getLastLoggedInUser(success: (User) -> Void, failure: (GetLastLoggedInUserError) -> Void)
}
