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
    @IBOutlet weak var noAlarmView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
	//MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if AlarmController.shareController.alarmArray.count == 0 {
//            self.noAlarmView.isHidden = false
//        } else if AlarmController.shareController.alarmArray.count > 0 {
//            self.noAlarmView.isHidden = true
//            tableView.reloadData()
//        }
        
        tableView.reloadData()
    }
    
    
    //MARK: IBActions
    @IBAction func scheduleNotificationTapped(_ sender: AnyObject) {
        NotificationManager.sharedController.scheduleAlarmNotification(inSeconds: 10) { (true) in
            if true {
                print("scheduled notification")
            }
        }
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
//        if AlarmController.shareController.alarmArray.count > 0 {
//            self.noAlarmView.isHidden = true 
//            
//            return AlarmController.shareController.alarmArray.count
//        } else if AlarmController.shareController.alarmArray.count == 0 {
//            self.noAlarmView.isHidden = false
//        }
//        
//        return 0
        
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
            
            //NotificationManager.sharedController.scheduleAlarmNotification(alarm: alarm)
            
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
            //NotificationManager.sharedController.scheduleAlarmNotification(alarm: alarm)
        } else {
            //NotificationManager.sharedController.cancelAlarmNotification(alarm: alarm)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
