//
//  AlarmController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol AlarmScheduler {
    func scheduleLocalNotification(_ alarm: Alarm)
    func cancelLocalNotification(_ alarm: Alarm)
}


class AlarmController {
    
    private let kAlarms = "Alarms"
    
    //MARK: Singleton
    static let shareController = AlarmController()
    
    
    //MARK: Properties
    var alarmArray: [Alarm]
    
    
    //MARK: Init
    init() {
        alarmArray = []
        loadFromPersistantStorage()
    }
    
    
    //MARK: Helper Functions
    func addAlarm(_ name: String, fireTimeFromMidnight: TimeInterval) {
    	let alarm = Alarm(name: name, fireTimeFromMidnight: fireTimeFromMidnight)
        alarmArray.append(alarm)
        
        saveToPersistantStorage()
    }
    
    func updateAlarm(_ alarm: Alarm, name: String, fireTimeFromMidnight: TimeInterval) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        
        saveToPersistantStorage()
    }
    
    func deleteAlarm(_ alarm: Alarm) {
        guard let index = alarmArray.index(of: alarm) else {return}
        alarmArray.remove(at: index)
        
        saveToPersistantStorage()
    }
    
    func toggleEnabled(_ alarm: Alarm) {
    	alarm.enabled = !alarm.enabled
        
        saveToPersistantStorage()
    }
    
    
    
    
    //MARK: NSCoding
    
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarmArray, toFile: self.filePath(key: kAlarms))
    }
    
    func loadFromPersistantStorage() {
        let unarchivedAlarms = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath(key: kAlarms))
        
        if let alarm = unarchivedAlarms as? [Alarm] {
            self.alarmArray = alarm
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let documentPath: AnyObject = directorySearchResults[0] as AnyObject
        let alarmPath = documentPath.appending("/\(key).plist")
        
        return alarmPath
    }
    
}

/*
extension AlarmScheduler {
    
    func scheduleLocalNotification(_ alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Time is up!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Your alarm titled \(alarm.name) is done!", arguments: nil)
        content.sound = .default()
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: TimeInterval(alarm.fireDate), repeats: true)
        let request = UNNotificationRequest.init(identifier: "alarm", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: nil)
        
        /*
        let localNotification = UILocalNotification()
        
        localNotification.category = alarm.uuid
        localNotification.alertTitle = "Time is up!"
        localNotification.alertBody = "Your alarm titled \(alarm.name) is done!"
        localNotification.fireDate = alarm.fireDate as Date?
        localNotification.repeatInterval = .day
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
 		*/
    }
    
    func cancelLocalNotification(_ alarm: Alarm) {
        let center = UNUserNotificationCenter.current()
        
        /*
        guard let scheduledLocalNotification = UIApplication.shared.scheduledLocalNotifications else {return}
        
        for notification in scheduledLocalNotification {
            if notification.category ?? "" == alarm.uuid {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }
 		*/
    }
}
*/

