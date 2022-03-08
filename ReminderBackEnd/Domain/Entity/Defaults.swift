//
//  Defaults.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation


/// Conforming to this protocol will convert
public protocol Defaults {
    
}

extension Defaults {
    /// Returns the `defaultValue` if the `mainValue` is `nil`, else returns `mainValue`
    ///
    /// - Parameters:
    ///  - mainvalue: The mainValue which is considered if it is not nil
    ///  - defaultValue: The value which should be considered if the `mainValue` is nil
    static func setValue<Element>(mainValue: Element?, defaultValue: Element) -> Element {
        return mainValue ?? defaultValue
    }
}



/// Returns the default values of the `Reminder` parameters
public class ReminderDefaults: Defaults {
    private init() {}
    
    /// Default title for Reminder
    static var title: String {
        get {
            "\(Constant.shared.REMINDER_TITLE)-\(Date.now.description(with: Locale.current))"
        }
        set {
            Constant.shared.REMINDER_TITLE = newValue
        }
    }
    
    /// Default description for Reminder
    static var description: String {
        get {
            return Constant.shared.REMINDER_DESCRIPTION
        }
        set {
            Constant.shared.REMINDER_DESCRIPTION = newValue
        }
    }
    
    /// Default time when the Reminder rings
    /// Default time set here is one hour(3600 seconds) after the time when Reminder was added
    static var eventTime: Date {
        Date.now + Constant.shared.REMINDER_EVENT_TIME.rawValue
    }
    
    /// Default ringing sound of the Reminder
    static var sound: String {
        get {
            Constant.shared.REMINDER_SOUND_PATH
        }
        set {
            Constant.shared.REMINDER_SOUND_PATH = newValue
        }
    }
    
    /// Pattern when the Reminder repeats
    /// Default pattern is no repetitions
    static var repeatTiming: RepeatPattern {
        get {
            Constant.shared.REMINDER_REPEAT_PATTERN
        }
        set {
            Constant.shared.REMINDER_REPEAT_PATTERN = newValue
        }
    }
    
    /// Set of `TimeInterval`s when the Reminder should ring before the `eventTime`
    /// By default the reminder rings 30 minutes before the `eventTime`
    static var ringTimeIntervals: Set<TimeInterval> {
        get {
            Constant.shared.REMINDER_RING_TIME_INTERVALS
        }
        set {
            Constant.shared.REMINDER_RING_TIME_INTERVALS = newValue
        }
    }
//    let reminderView = ReminderView(self)
    
    static func setDefault(title: String) {
        Self.title = title
    }
    
    static func setDefault(description: String) {
        Self.description = description
    }
    
    static func setDefault(repeatTiming: RepeatPattern) {
        Self.repeatTiming = repeatTiming
    }
    
    static func setDefault(ringTimeIntervals: Set<TimeInterval>) {
        Self.ringTimeIntervals = ringTimeIntervals
    }
    
    static func setValue(title: String?) -> String {
        return title ?? Self.title
    }
    
    static func setValue(description: String?) -> String {
        return description ?? Self.description
    }
    
    static func setValue(eventTime: Date?) -> Date {
        return eventTime ?? Self.eventTime
    }
    
    static func setValue(sound: String?) -> String {
        return sound ?? Self.sound
    }
    
    static func setValue(repeatTiming: RepeatPattern?) -> RepeatPattern {
        return repeatTiming ?? Self.repeatTiming
    }
    
    static func setValue(ringTimeIntervals: Set<TimeInterval>?) -> Set<TimeInterval> {
        return ringTimeIntervals ?? Self.ringTimeIntervals
    }
}
