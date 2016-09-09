//
//  AlarmController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK: Singleton
    static let shareController = AlarmController()
    
    
    var alarmArray: [Alarm] = []
    
    
    
    
    //MARK: Helper Functions
    func addAlarm(name: String, fireTimeFromMidnight: NSTimeInterval) -> Alarm {
    	let alarm = Alarm(name: name, fireTimeFromMidnight: fireTimeFromMidnight)
        alarmArray.append(alarm)
        
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, name: String, fireTimeFromMidnight: NSTimeInterval) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarmArray.indexOf(alarm) else {return}
        alarmArray.removeAtIndex(index)
    }
    
    func toggleEnabled(alarm: Alarm) {
    	alarm.enabled = !alarm.enabled
    }
}