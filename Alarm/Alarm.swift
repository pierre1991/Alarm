//
//  Alarm.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
    
    private let kName = "name"
    private let kFireTimeFromMidnight = "fireTimeFromMidnight"
    private let kEnabled = "enabled"
    private let kUUID = "UUID"
    
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
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
    
    init(name: String, fireTimeFromMidnight: NSTimeInterval, enabled: Bool = true, uuid: String = NSUUID().UUIDString) {
        self.name = name
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.enabled = enabled
        self.uuid = uuid
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(kName) as? String,
        	fireTimeFromMidnight = aDecoder.decodeObjectForKey(kFireTimeFromMidnight) as? NSTimeInterval,
            enabled = aDecoder.decodeObjectForKey(kEnabled) as? Bool,
            uuid = aDecoder.decodeObjectForKey(kUUID) as? String else {return nil}
        self.name = name
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.enabled = enabled
        self.uuid = uuid
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
    	aCoder.encodeObject(name, forKey: kName)
        aCoder.encodeObject(fireTimeFromMidnight, forKey: kFireTimeFromMidnight)
        aCoder.encodeObject(enabled, forKey: kEnabled)
        aCoder.encodeObject(uuid, forKey: kUUID)
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}