//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    
    //MARK: Properties
    var alarm: Alarm?
    
    
    //MARK: IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        
        setupView()
	}

    
    
    //MARK: IBActions
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        guard let title = detailTextField.text, let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight as Date)
        
        if let alarm = alarm {
            AlarmController.shareController.updateAlarm(alarm, name: title, fireTimeFromMidnight: timeIntervalSinceMidnight)
            //NotificationManager.sharedController.cancelAlarmNotification(alarm: alarm)
            //NotificationManager.sharedController.scheduleAlarmNotification(alarm: alarm)
        } else {
            let alarm = AlarmController.shareController.addAlarm(title, fireTimeFromMidnight: timeIntervalSinceMidnight)
            self.alarm = alarm
            //NotificationManager.sharedController.scheduleAlarmNotification(alarm: alarm)
        }
    	
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enableButtonTapped(_ sender: AnyObject) {
        guard let alarm = alarm else {return}
        
        AlarmController.shareController.toggleEnabled(alarm)
        
        if alarm.enabled {
            //NotificationManager.sharedController.scheduleAlarmNotification(alarm: alarm)
        } else {
            //NotificationManager.sharedController.cancelAlarmNotification(alarm: alarm)
        }
        
        setupView()
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


    func updateWithAlarm(_ alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
    	datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        detailTextField.text = alarm.name
        self.title = alarm.name
    }
    
    
    func setupView() {
        if alarm == nil {
            enableButton.isHidden = true
        } else {
            enableButton.isHidden = false
            
            if alarm?.enabled == true {
                enableButton.setTitle("Disable", for: .normal)
                enableButton.setTitleColor(.red, for: .normal)
                enableButton.backgroundColor = .red
            } else {
                enableButton.setTitle("Enable", for: .normal)
                enableButton.setTitleColor(.blue, for: .normal)
                enableButton.backgroundColor = .gray
            }
        }
    }
}
