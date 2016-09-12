//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UIViewController, AlarmScheduler {

    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
	//MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    //MARK: Navigation 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as? AlarmDetailTableViewController

        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.shareController.alarmArray[indexPath.row]
            destinationViewController?.alarm = alarm
        }
    }
}


extension AlarmListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shareController.alarmArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as? AlarmTableViewCell ?? AlarmTableViewCell()
        let alarm = AlarmController.shareController.alarmArray[indexPath.row]
        
        cell.updateAlarm(alarm)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        	let alarm = AlarmController.shareController.alarmArray[indexPath.row]
            AlarmController.shareController.deleteAlarm(alarm)
            cancelLocalNotification(alarm)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    	}
    }
}


extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    func switchValueChanged(cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(cell) else {return}
        
        let alarm = AlarmController.shareController.alarmArray[indexPath.row]
        AlarmController.shareController.toggleEnabled(alarm)
        
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}