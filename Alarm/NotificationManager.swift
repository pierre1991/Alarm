//
//  NotificationManager.swift
//  Alarm
//
//  Created by Pierre on 9/14/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    static let sharedController = NotificationManager()
    
    let center = UNUserNotificationCenter.current()
    
    
    func registerForNotifications() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification access granted")
            } else if (error != nil) {
                print("you will not be able to set Alarm Notifications")
            }
        }
    }
    
    
    
    func scheduleAlarmNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> Void) {
        let myImage = "candybars"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {return}
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "gifNotification", url: imageURL, options: .none)
            
        let notification = UNMutableNotificationContent()
        notification.title = "New notification"
        notification.body = "These are great!"
        notification.sound = .default()
        notification.attachments = [attachment]
        notification.categoryIdentifier = "myNotificationCategory"
        
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "alarmNotification", content: notification, trigger: trigger)
        
		center.add(request) { (error) in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    
    func cancelAlarmNotification(alarm: Alarm) {
        //let center = UNUserNotificationCenter.current()
    }
    
}
