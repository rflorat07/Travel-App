//
//  RegisterViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 07/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var viewController: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
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
    
    func showAlertController(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            AuthService.intance.registerUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, username: self.usernameTextField.text) { (success, registrationError) in
                
                if success {
                    
                    self.dismissView()
                    
                    print("Successfully registered user")
                    
                } else {
                    
                    print(String(describing: registrationError?.localizedDescription))
                    
                    self.showAlertController(title: "Error", message: registrationError!.localizedDescription)
                }
                
            }
            
        }
        
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
