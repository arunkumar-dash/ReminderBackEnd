//
//  RemoveUserDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol RemoveUserDataManagerContract {
    func removeUser(username: String, success: (String) -> Void, failure: (RemoveUserError) -> Void)
}
