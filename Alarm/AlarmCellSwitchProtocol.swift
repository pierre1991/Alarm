//
//  AlarmCellSwitchProtocol.swift
//  Alarm
//
//  Created by Pierre on 9/9/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

protocol SwitchTableViewCellDelegate: class {
    
    func switchValueChanged(cell: AlarmTableViewCell)
    
}