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
    var fireTimeFromMidnight: TimeInterval
    var enabled: Bool
    var uuid: String
    
    var fireDate: Date? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return nil}
        let fireDateFromThisMorning = Date(timeInterval: fireTimeFromMidnight, since: thisMorningAtMidnight as Date)
        
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
    
    init(name: String, fireTimeFromMidnight: TimeInterval, enabled: Bool = true, uuid: String = UUID().uuidString) {
        self.name = name
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.enabled = enabled
        self.uuid = uuid
    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: kName)
        aCoder.encode(fireTimeFromMidnight, forKey: kFireTimeFromMidnight)
        aCoder.encode(enabled, forKey: kEnabled)
        aCoder.encode(uuid, forKey: kUUID)
    }
    
    required init?(coder aDecoder: NSCoder) {
    	guard let name = aDecoder.decodeObject(forKey: kName) as? String,
            let uuid = aDecoder.decodeObject(forKey: kUUID) as? String else {return nil}
        
        self.name = name
        self.uuid = uuid
        self.fireTimeFromMidnight = aDecoder.decodeDouble(forKey: kFireTimeFromMidnight)
        self.enabled = aDecoder.decodeBool(forKey: kEnabled)
    }
}


func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}

/*
Given an array that contains instances that conform to the MoFoEmployee protocol as described below:

// Objective-C
@protocol MoFoEmployee <NSObject>

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *middleName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *startDate;

@end

// Swift
public protocol MoFoEmployee: Comparable {
    
    var firstName: String { get set }
    var middleName: String? { get set }
    var lastName: String { get set }
    var startDate: NSDate { get set }
}

write a method that prints the names of all employees that have started at least 30 days ago sorted in order of starting date.  Are there other ways to sort the array than the method you chose?  Describe any advantages or disadvantages of the approaches.

*/
