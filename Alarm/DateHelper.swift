//
//  DateHelper.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var calendar: Calendar {
        return Calendar.current
    }
    
    static var thisMorningAtMidnight: Date? {
        var components = (calendar as NSCalendar).components([.month, .day, .year], from: Date())
        components.nanosecond = 0
        components.second = 0
        components.minute = 0
        components.hour = 0
        
        return calendar.date(from: components)
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        var components = (calendar as NSCalendar).components([.month, .day, .year], from: Date())
        components.nanosecond = 0
        components.second = 0
        components.minute = 0
        components.hour = 0
        
        guard let date = calendar.date(from: components) else {return nil}
        
        return Date(timeInterval: 24*60*60, since: date)
    }
    
}
