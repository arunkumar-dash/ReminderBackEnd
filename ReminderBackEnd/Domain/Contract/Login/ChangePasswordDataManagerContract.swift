//
//  ChangePasswordDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol ChangePasswordDataManagerContract {
    func changePassword(username: String, password: String, success: (String) -> Void, failure: (ChangePasswordError) -> Void)
}
