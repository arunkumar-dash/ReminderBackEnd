//
//  User.swift
//  Reminder
//
//  Created by Arun Kumar on 07/03/22.
//

import Foundation

public class User: Codable {
    public let imageURL: URL?
    public let username: String
    public let password: String
    public init(username: String, password: String, imageURL: URL? = nil) {
        self.username = username
        self.password = password
        self.imageURL = imageURL
    }
}

