//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UIViewController {

    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
	//MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension AlarmListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shareController.alarmArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as! AlarmTableViewCell
        
        let alarm = AlarmController.shareController.alarmArray[indexPath.row]
        
        cell.updateAlarm(alarm)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        	let alarm = AlarmController.shareController.alarmArray[indexPath.row]
            AlarmController.shareController.deleteAlarm(alarm)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    	}
    }
}
