//
//  LoginViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 07/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var showAlertController : UIAlertController!
    var activityIndicator : UIActivityIndicatorView!
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGestureRecognizer()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        showActivityIndicator()
        
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            AuthService.intance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
                
                if success {
                    self.dismissActivityIndicator()
                    self.performSegue(withIdentifier: "LOGIN_TO_MAIN", sender: nil)
                } else {
                    self.dismissActivityIndicator(loginError: loginError)
                }
            })
        } else {
            dismissActivityIndicator()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismissView()
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
    
    func showActivityIndicator() {
        
        showAlertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating();
        
        showAlertController.view.addSubview(activityIndicator)
        
        present(showAlertController, animated: true, completion: nil)
        
    }
    
    func dismissActivityIndicator(loginError: Error? = nil) {
        showAlertController.dismiss(animated: true) {
            if let error = loginError {
                self.showAlertController(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
