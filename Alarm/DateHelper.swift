//
//  DateHelper.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var calendar: NSCalendar {
        return NSCalendar.currentCalendar()
    }
    
    static var thisMorningAtMidnight: NSDate? {
        let components = calendar.components([.Month, .Day, .Year], fromDate: NSDate())
        components.nanosecond = 0
        components.second = 0
        components.minute = 0
        components.hour = 0
        
        return calendar.dateFromComponents(components)
    }
    
    static var tomorrowMorningAtMidnight: NSDate? {
        let components = calendar.components([.Month, .Day, .Year], fromDate: NSDate())
        components.nanosecond = 0
        components.second = 0
        components.minute = 0
        components.hour = 0
        
        guard let date = calendar.dateFromComponents(components) else {return nil}
        
        return NSDate(timeInterval: 24*60*60, sinceDate: date)
    }
    
}