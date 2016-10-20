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
        UINavigationBar.appearance().barTintColor = .barTintGreenColor()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        
        UITabBar.appearance().barTintColor = .barTintGreenColor()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barStyle = .black
    }
}
