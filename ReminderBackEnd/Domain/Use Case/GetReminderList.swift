//
//  GetReminderList.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

public final class GetReminderListRequest {
    var username: String
    public init(username: String) {
        self.username = username
    }
}

public final class GetReminderListResponse {
    public var reminders: [Reminder]
    public init(reminders: [Reminder]) {
        self.reminders = reminders
    }
}

public final class GetReminderListError {
    var status: Status
    
    public enum Status {
        case noDatabaseConnection
        case noDataFound
    }
    
    public init(status: Status) {
        self.status = status
    }
}

struct UsecaseQueue {
    static let queue: DispatchQueue = DispatchQueue(label: Bundle.main.bundleIdentifier!, attributes: .concurrent)
}

public class GetReminderList {
    var dataManager: GetReminderListDataManagerContract
    
    public init(dataManager: GetReminderListDataManagerContract) {
        self.dataManager = dataManager
    }
    
    public func run(request: GetReminderListRequest, success: @escaping (GetReminderListResponse) -> Void, failure:  @escaping (GetReminderListError) -> Void) {
        UsecaseQueue.queue.async {
            [weak self]
            in
            self?.dataManager.getReminderList(username: request.username, success: {
                [weak self]
                (reminders) in
                self?.success(reminders: reminders, callback: success)
            }, failure: {
                [weak self]
                (error) in
                self?.failure(error: error, callback: failure)
            })
        }
    }
    
    private func success(reminders: [Reminder], callback: @escaping (GetReminderListResponse) -> Void) {
        let response = GetReminderListResponse(reminders: reminders)
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func failure(error: GetReminderListError, callback: @escaping (GetReminderListError) -> Void) {
        if Thread.isMainThread {
            callback(error)
        } else {
            DispatchQueue.main.async {
                callback(error)
            }
        }
    }
}
