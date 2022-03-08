//
//  GetAllUsersDataManagerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 08/03/22.
//

import Foundation

public protocol GetAllUsersDataManagerContract {
    func getAllUsers(success: ([User]) -> Void, failure: (GetAllUsersError) -> Void)
}
