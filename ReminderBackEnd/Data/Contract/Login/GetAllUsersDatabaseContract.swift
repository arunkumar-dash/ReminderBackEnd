//
//  GetAllUsersDatabaseContract.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public protocol GetAllUsersDatabaseContract {
    func getAllUsers(success: ([User]) -> Void, failure: (String) -> Void)
}
