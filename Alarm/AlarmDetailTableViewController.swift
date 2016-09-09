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
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = detailTextField.text, thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
        
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        
        if let alarm = alarm {
            AlarmController.shareController.updateAlarm(alarm, name: title, fireTimeFromMidnight: timeIntervalSinceMidnight)
        } else {
            let alarm = AlarmController.shareController.addAlarm(title, fireTimeFromMidnight: timeIntervalSinceMidnight)
            self.alarm = alarm 
        }
    	
    	self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func enableButtonTapped(sender: AnyObject) {
    }
    

    func updateWithAlarm(alarm: Alarm) {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else {return}
    
        datePicker.setDate(NSDate(timeInterval: alarm.fireTimeFromMidnight, sinceDate: thisMorningAtMidnight), animated: false)
        detailTextField.text = alarm.name
        self.title = alarm.name
    }
    
    
    func setupView() {
        if alarm == nil {
            enableButton.hidden = true
        } else {
            enableButton.hidden = false
            
            if alarm?.enabled == true {
            	enableButton.setTitle("Disable", forState: .Normal)
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
                enableButton.backgroundColor = .redColor()
            } else {
                enableButton.setTitle("Enable", forState: .Normal)
                enableButton.setTitleColor(.whiteColor(), forState: .Normal)
                enableButton.backgroundColor = .greenColor()
            }
        }
    }
}