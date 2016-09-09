//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    
    //MARK: IBOutlets
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    
    //MARK: Nib Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //MARK: IBActions
    @IBAction func switchValueChanged(sender: AnyObject) {
    }
    
    
    func updateAlarm(alarm: Alarm) {
    	hourLabel.text = alarm.fireTimeAsString
        detailLabel.text = alarm.name
        alarmSwitch.on = alarm.enabled
    }
}
