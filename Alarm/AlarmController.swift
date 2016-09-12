//
//  AlarmController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

protocol AlarmScheduler {
    func scheduleLocalNotification(alarm: Alarm)
    func cancelLocalNotification(alarm: Alarm)
}


class AlarmController {
    
    private let kAlarms = "Alarms"
    
    
    //MARK: Singleton
    static let shareController = AlarmController()
    
    
    //MARK: Properties
    var alarmArray: [Alarm] = []
    
    
    //MARK: Init
    init() {
        loadFromPersistantStorage()
    }
    
    
    //MARK: Helper Functions
    func addAlarm(name: String, fireTimeFromMidnight: NSTimeInterval) -> Alarm {
    	let alarm = Alarm(name: name, fireTimeFromMidnight: fireTimeFromMidnight)
        alarmArray.append(alarm)
        
        saveToPersistantStorage()
        
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, name: String, fireTimeFromMidnight: NSTimeInterval) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        
        saveToPersistantStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarmArray.indexOf(alarm) else {return}
        alarmArray.removeAtIndex(index)
        
        saveToPersistantStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
    	alarm.enabled = !alarm.enabled
        
        saveToPersistantStorage()
    }
    
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarmArray, toFile: filePath(kAlarms))
    }
    
    func loadFromPersistantStorage() {
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kAlarms)) as? [Alarm] else {return}
        self.alarmArray = alarms
    }
    
    
    
    func filePath(key: String) -> String {
    	let directorySearchResults = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true)
        let documentsPath = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("\(key).plist")
        
        return entriesPath
	}
}

extension AlarmScheduler {
    
    func scheduleLocalNotification(alarm: Alarm) {
        let localNotification = UILocalNotification()
        
        localNotification.category = alarm.uuid
        localNotification.alertTitle = "Time is up!"
        localNotification.alertBody = "Your alarm titled \(alarm.name) is done!"
        localNotification.fireDate = alarm.fireDate
        localNotification.repeatInterval = .Day
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(alarm: Alarm) {
        guard let scheduledLocalNotification = UIApplication.sharedApplication().scheduledLocalNotifications else {return}
        
        for notification in scheduledLocalNotification {
            if notification.category ?? "" == alarm.uuid {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
}