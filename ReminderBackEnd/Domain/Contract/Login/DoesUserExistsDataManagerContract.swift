//
//  DoesUserExistsDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public protocol DoesUserExistsDataManagerContract {
    func doesUserExists(username: String, success: (String) -> Void, failure: (DoesUserExistsError) -> Void)
}
