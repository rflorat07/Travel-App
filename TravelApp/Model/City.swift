//
//  City.swift
//  TravelApp
//
//  Created by Roger Florat on 27/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class City {
    
    private var _cityUID : String
    private var _cityTitle : String
    private var _cityBody : String
    private var _cityImage : String
    
    var cityUID: String {
        return _cityUID
    }
    
    var cityTitle: String {
        return _cityTitle
    }
    
    var cityBody: String {
        return _cityBody
    }
    
    var cityImage: String {
        return _cityImage
    }
    
    init(uid: String, title: String, body: String, image: String) {
        self._cityUID   = uid
        self._cityTitle = title
        self._cityBody  = body
        self._cityImage = image
    }
    
}
