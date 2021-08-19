//
//  TimerToMinute.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 18/08/21.
//

import Foundation
/// Represents parts of time
struct TimeParts: CustomStringConvertible {
    var seconds = 0
    var minutes = 0
    /// The string representation of the time parts (ex: 07:37)
    var description: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
}

/// Represents unset or empty time parts
let EmptyTimeParts = 0.toTimeParts()

extension Int {
    /// The time parts for this integer represented from total seconds in time.
    /// -- returns: A TimeParts struct that describes the parts of time
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
    
    /// The string representation of the time parts (ex: 07:37)
    func asTimeString() -> String {
        return toTimeParts().description
    }
}
