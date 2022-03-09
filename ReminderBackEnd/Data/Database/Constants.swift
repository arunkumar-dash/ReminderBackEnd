//
//  Constants.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

extension TimeInterval: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!
    }
}

struct Constants: Codable {
    
    var DB_FOLDER = ".ReminderAppDatabase"
    
    var IMAGE_FOLDER = ".Images"
    
    var lastLoggedInUser: User? = nil {
        didSet {
            self.sync()
        }
    }
    
    var REMINDER_SOUND_PATH = "/Users/arun-pt4306/Downloads/sound.wav" {
        didSet {
            self.sync()
        }
    }
    
    enum TimeIntervals: TimeInterval, CaseIterable, Codable {
        case oneHour = 3600
        case halfHour = 1800
        case fifteenMinutes = 900
        case tenMinutes = 600
        case fiveMinutes = 300
    }
    
    var REMINDER_TITLE = "Reminder" {
        didSet {
            self.sync()
        }
    }
    
    var REMINDER_DESCRIPTION = "Your description goes here..." {
        didSet {
            self.sync()
        }
    }
    
    var REMINDER_REPEAT_PATTERN: RepeatPattern = .never {
        didSet {
            self.sync()
        }
    }
    
    var REMINDER_EVENT_TIME: TimeIntervals = .oneHour {
        didSet {
            self.sync()
        }
    }
    
    var REMINDER_RING_TIME_INTERVALS: Set<TimeInterval> = Set([Constants.TimeIntervals.halfHour.rawValue]) {
        didSet {
            self.sync()
        }
    }
    
    var NOTIFICATION_SNOOZE_TIME = Constants.TimeIntervals.tenMinutes.rawValue {
        didSet {
            self.sync()
        }
    }
    
    init() {
        updateFromDB()
    }
    
    mutating func updateFromDB() {
        let databaseFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(self.DB_FOLDER)
        
        do {
            try FileManager.default.createDirectory(at: databaseFolder, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Failed to create directory while connecting to defaults database")
            print(error)
            return
        }
        
        let url = databaseFolder.appendingPathComponent("defaults.json")
        if let data = try? Data(contentsOf: url) {
            print("Saved defaults file found")
            if let constant = try? JSONDecoder().decode(Self.self, from: data) {
                self = constant
                print("Saved defaults decoded")
            } else {
                print("Cannot decode the defaults file from database")
                return
            }
        } else {
            do {
                try JSONEncoder().encode(self).write(to: url)
            } catch let error {
                print("Cannot encode defaults to a file")
                print(error)
                return
            }
            print("New defaults file created")
        }
    }
    
    private func sync() {
        let databaseFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(self.DB_FOLDER)
        
        do {
            try FileManager.default.createDirectory(at: databaseFolder, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Failed to create directory while connecting to defaults database")
            print(error)
            return
        }
        
        let url = databaseFolder.appendingPathComponent("defaults.json")
        do {
            try JSONEncoder().encode(self).write(to: url)
        } catch let error {
            print("Cannot encode defaults to a file")
            print(error)
            return
        }
    }
}
