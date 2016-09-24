//
//  Extensions.swift
//  Alarm
//
//  Created by Pierre on 9/16/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CircularButton: UIButton {
 
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupCircularButton()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCircularButton()
    }
    
    
    func setupCircularButton() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
}
