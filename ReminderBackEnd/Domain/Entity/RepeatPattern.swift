//
//  RepeatPattern.swift
//  Reminder
//
//  Created by Arun Kumar on 04/03/22.
//

import Foundation

/// Pattern to repeat the `Reminder`
public enum RepeatPattern: CaseIterable, Codable {
    
    /// temporary case
    case everyMinute
    
    /// Repeats every day
    case everyDay
    /// Repeats every week
    case everyWeek
    /// Repeats every month
    case everyMonth
    /// Repeats every year
    case everyYear
    /// Repeats never
    case never
}
