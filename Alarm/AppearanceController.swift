//
//  AppearanceController.swift
//  Alarm
//
//  Created by Pierre on 9/12/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearanceDefaults() {
        UINavigationBar.appearance().barTintColor = UIColor.barTintGreenColor()
        UINavigationBar.appearance().isTranslucent = false
        
        UITabBar.appearance().barTintColor = UIColor.barTintGreenColor()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = UIColor.white
    }
}
