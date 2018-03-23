//
//  UISwitchCustom.swift
//  TravelApp
//
//  Created by Roger Florat on 22/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//


import UIKit
@IBDesignable

class UICustomSwitch : UISwitch {
    
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}

