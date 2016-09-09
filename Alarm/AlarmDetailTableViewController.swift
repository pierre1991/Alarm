//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    
    //MARK: IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
	}

    
    
    //MARK: IBActions
    @IBAction func enableButtonTapped(sender: AnyObject) {
    }
    

    
    // MARK: - Table view data source
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }



}
