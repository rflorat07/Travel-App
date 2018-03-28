//
//  SplashViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 06/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LOGIN", sender: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "REGISTER", sender: nil)
    }
}

