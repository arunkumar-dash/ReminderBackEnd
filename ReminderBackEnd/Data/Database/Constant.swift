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

struct Constant: Codable {
    
    static let DB_FOLDER = ".ReminderAppDatabase"
    
    static let IMAGE_FOLDER = ".Images"
    
    var lastLoggedInUser: User? = nil
    
    var REMINDER_SOUND_PATH = "/Users/arun-pt4306/Downloads/sound.wav"
    
    enum TimeIntervals: TimeInterval, CaseIterable, Codable {
        case oneHour = 3600
        case halfHour = 1800
        case fifteenMinutes = 900
        case tenMinutes = 600
        case fiveMinutes = 300
    }
    
    var REMINDER_TITLE = "Reminder"
    
    var REMINDER_DESCRIPTION = "Your description goes here..."
    
    var REMINDER_REPEAT_PATTERN: RepeatPattern = .never
    
    var REMINDER_EVENT_TIME: TimeIntervals = .oneHour
    
    var REMINDER_RING_TIME_INTERVALS: Set<TimeInterval> = Set([Constant.TimeIntervals.halfHour.rawValue])
    
    var NOTIFICATION_SNOOZE_TIME = Constant.TimeIntervals.tenMinutes.rawValue
    
    private init() {
        
    }
    
    static func updateFromDB() {
        let databaseFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(Constant.DB_FOLDER)
        
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
                Constant.shared = constant
                print("Saved defaults decoded")
            } else {
                print("Cannot decode the defaults file from database")
                return
            }
        } else {
            do {
                try JSONEncoder().encode(Constant.shared).write(to: url)
            } catch let error {
                print("Cannot encode defaults to a file")
                print(error)
                return
            }
            print("New defaults file created")
        }
    }
    
    private static func sync() {
        let databaseFolder = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0].appendingPathComponent(Constant.DB_FOLDER)
        
        do {
            try FileManager.default.createDirectory(at: databaseFolder, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print("Failed to create directory while connecting to defaults database")
            print(error)
            return
        }
        
        let url = databaseFolder.appendingPathComponent("defaults.json")
        do {
            try JSONEncoder().encode(Constant.shared).write(to: url)
        } catch let error {
            print("Cannot encode defaults to a file")
            print(error)
            return
        }
    }
    
    static var shared = Constant() {
        didSet {
            Constant.sync()
        }
    }
}
