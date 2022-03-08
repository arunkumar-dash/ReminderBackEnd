//
//  Reminder.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation


/// Types that conform to `ReminderProtocol` are Reminders
public protocol ReminderContract: Identifiable {
    /// Title of the Reminder
    var title: String { get }
    /// Description of the Reminder
    var description: String { get }
    /// The date and time when Reminder was added
    var addedTime: Date { get }
    /// The date and time of the Event
    var eventTime: Date { get }
    /// The sound when Reminder rings
    var sound: String { get }
    /// The frequency to repeat the Reminder
    var repeatTiming: RepeatPattern { get }
    /// The set of `TimeInterval`s the reminder should ring before the `eventTime`
    var ringTimeIntervals: Set<TimeInterval> { get }
    /// The set of `Date`s the reminder should ring before the `eventTime`
    var ringDates: Set<Date> { get }
    // creating this property for notification syncing purpose
    var id: Int32? { get set }
    
//    let reminderView = ReminderView(self)
}

/// Returns a `Reminder` instance
public struct Reminder: ReminderContract, Codable {
    
//    let reminderView = ReminderView(self)
    /// The title of the Reminder
    public var title: String
    /// The description of the Reminder
    public var description: String
    /// The time when Reminder was added
    public var addedTime: Date
    /// The time when the Reminder should ring
    public var eventTime: Date
    /// The sound of the Reminder
    public var sound: String
    /// The `RepeatPattern` of the Reminder
    public var repeatTiming: RepeatPattern
    /// The set of `TimeInterval`s before the `eventTime` when the Reminder should ring
    public var ringTimeIntervals: Set<TimeInterval>
    /// The set of `Date`s the reminder should ring before the `eventTime`
    public var ringDates: Set<Date> {
        get {
            var set = Set<Date>([eventTime])
            for timeInterval in ringTimeIntervals {
                let totalTimeInterval = eventTime.timeIntervalSince(addedTime)
                let timeIntervalSinceAddedTime = totalTimeInterval - timeInterval
                let ringTime = Date(timeInterval: timeIntervalSinceAddedTime, since: addedTime)
                set.insert(ringTime)
            }
            return set
        }
    }
    // creating this property for notification syncing purpose
    public var id: Int32? = nil
    
    public init(addedTime: Date, title: String? = nil, description: String? = nil, eventTime: Date? = nil,
         sound: String? = nil, repeatTiming: RepeatPattern? = nil, ringTimeIntervals: Set<TimeInterval>? = nil) {
        self.addedTime = addedTime
        self.title = ReminderDefaults.setValue(title: title)
        self.description = ReminderDefaults.setValue(description: description)
        self.eventTime = ReminderDefaults.setValue(eventTime: eventTime)
        self.sound = ReminderDefaults.setValue(sound: sound)
        self.repeatTiming = ReminderDefaults.setValue(repeatTiming: repeatTiming)
        self.ringTimeIntervals = ReminderDefaults.setValue(ringTimeIntervals: ringTimeIntervals)
    }
}
