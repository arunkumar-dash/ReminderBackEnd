//
//  GetLastLoggedInUserDatabaseService.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class GetLastLoggedInUserDatabaseService: GetLastLoggedInUserDatabaseContract {
    public init() {
        
    }
    deinit {
        
    }
    
    public func getLastLoggedInUser(success: (User) -> Void, failure: (String) -> Void) {
        let constants = Constants()
        let lastLoggedInUser = constants.lastLoggedInUser
        if let lastLoggedInUser = lastLoggedInUser {
            success(lastLoggedInUser)
        } else {
            failure("No User Found")
        }
    }
}
