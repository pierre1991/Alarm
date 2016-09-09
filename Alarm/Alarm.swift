//
//  Alarm.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Alarm: Equatable {
    
    var name: String
    var fireTimeFromMidnight: NSTimeInterval
    var enabled: Bool
    var uuid: String
    
    var fireDate: NSDate? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return nil}
        
        let fireDateFromThisMorning = NSDate(timeInterval: fireTimeFromMidnight, sinceDate: thisMorningAtMidnight)
        
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        
        if hours >= 13 {
        	return String(format: "%2d:%02d PM", [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            
            return String(format: "%2d:%02d AM", [hours, minutes])
        }
    }
    
    init(name: String, fireTimeFromMidnight: NSTimeInterval, enabled: Bool = true, uuid: String = NSUUID().UUIDString) {
        self.name = name
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.enabled = enabled
        self.uuid = uuid
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}