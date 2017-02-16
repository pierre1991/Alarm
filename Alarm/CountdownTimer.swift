//
//  Timer.swift
//  Alarm
//
//  Created by Pierre on 9/15/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class CountdownTimer: NSObject {
    
    static let kSecondsTick = "secondsTickNotification"
    static let kTimerComplete = "timerCompleteNotification"
    
    private(set) var seconds = TimeInterval(0)
    private(set) var totalSeconds = TimeInterval(0)
    var countdownTimer: Timer?
	
    var isOn: Bool {
        get {
            if countdownTimer != nil {
                return true
            } else {
                return false 
            }
        }
    }
    
    var timeString: String {
        get {
            let totalSeconds = Int(self.seconds)
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var hoursString = ""
            if hours > 0 {
                hoursString = "\(hours):"
            }
            
            var minutesString = ""
            if minutes < 10 {
                minutesString = "0\(minutes):"
            } else {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if seconds < 10 {
                secondsString = "0\(seconds)"
            } else {
                secondsString = "\(seconds)"
            }
            
            return hoursString + minutesString + secondsString
        }
    }
    
    
    func setTimer(seconds: TimeInterval, totalSeconds: TimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    func startTimer() {
        if !isOn {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountdownTimer.secondTick), userInfo: nil, repeats: true)
        } else if isOn {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountdownTimer.secondTick), userInfo: nil, repeats: true)
        }
    }
    
    func pauseTimer() {
        if isOn {
            countdownTimer?.invalidate()
        }
    }
    
    func stopTimer() {
        if isOn {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    func secondTick() {
        if countdownTimer != nil {
            seconds -= 1
            
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CountdownTimer.kSecondsTick), object: self)
            
            if seconds <= 0 {
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CountdownTimer.kTimerComplete), object: self)
                
                stopTimer()
            }
        }
    }
    
}
