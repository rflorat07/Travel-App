//
//  AuthService.swift
//  TravelApp
//
//  Created by Roger Florat on 26/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let intance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, username: String?, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            
            if let error = error {
                
                userCreationComplete(false, error)
                
                print("Sign Up Unsuccessful: \(error.localizedDescription)")
                
            } else if let user = user {
                
                let userData = ["provider": user.providerID, "email": user.email, "username": username]
                
                DataService.instance.createDBUser(uid: user.uid, userData: userData )
                
                userCreationComplete(true, nil)
                
                print("Sign Up Successfully: \(user.uid)")
            }
        }
        
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                loginComplete(false, error)
                
                print("Login Unsuccessful: \(error.localizedDescription)")
                
            }
            else if let user = user {
                
                loginComplete(true, nil)
                
                print("Login Successfully: \(user.uid)")
            }
        }
    }
}
