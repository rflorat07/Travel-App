//
//  RegisterViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 07/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var viewController: UIView!
    
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGestureRecognizer()
    }
    
    func setGestureRecognizer () {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        viewController.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
