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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    //MARK: Navigation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? AlarmDetailTableViewController

        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.shareController.alarmArray[(indexPath as NSIndexPath).row]
            destinationViewController?.alarm = alarm
        }
    }
}


extension AlarmListTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shareController.alarmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell ?? AlarmTableViewCell()
        let alarm = AlarmController.shareController.alarmArray[(indexPath as NSIndexPath).row]
        
        cell.updateAlarm(alarm)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        	let alarm = AlarmController.shareController.alarmArray[(indexPath as NSIndexPath).row]
            AlarmController.shareController.deleteAlarm(alarm)
            cancelLocalNotification(alarm)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
    	}
    }
}


extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    func switchValueChanged(_ cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        let alarm = AlarmController.shareController.alarmArray[(indexPath as NSIndexPath).row]
        AlarmController.shareController.toggleEnabled(alarm)
        
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
