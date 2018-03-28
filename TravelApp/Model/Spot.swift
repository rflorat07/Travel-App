//
//  Spot.swift
//  TravelApp
//
//  Created by Roger Florat on 28/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class Spot {
    
    private var _spotTitle : String
    private var _spotCaption : String
    private var _spotBody : String
    private var _spotImage : String
    
    var spotTitle: String {
        return _spotTitle
    }
    
    var spotCaption: String {
        return _spotCaption
    }
    
    var spotBody: String {
        return _spotBody
    }
    
    var spotImage: String {
        return _spotImage
    }
    
    init( title: String, caption: String, body: String, image: String) {
        self._spotTitle = title
        self._spotCaption = caption
        self._spotBody = body
        self._spotImage = image
    }
    
}
