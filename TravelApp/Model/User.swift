//
//  User.swift
//  TravelApp
//
//  Created by Roger Florat on 30/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class User {
    
    private var _userName   : String
    private var _userCity   : String
    private var _userEmail  : String
    private var _userAvatar : String
    
    var userName : String {
        return _userName
    }
    
    var userCity : String {
        return _userCity
    }
    
    var userEmail : String {
        return _userEmail
    }
    
    var userAvatar : String {
        return _userAvatar
    }
    
    init(name: String, city: String, email: String, avatar: String ) {
        self._userName = name
        self._userCity = city
        self._userEmail = email
        self._userAvatar = avatar
    }
    
}
