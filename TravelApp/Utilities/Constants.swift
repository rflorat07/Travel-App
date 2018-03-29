//
//  Constants.swift
//  TravelApp
//
//  Created by Roger Florat on 26/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation
import Firebase

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let DB_BASE = Database.database().reference()


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
