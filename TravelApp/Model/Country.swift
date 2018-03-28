//
//  Country.swift
//  TravelApp
//
//  Created by Roger Florat on 27/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class Country {
    
    private var _countryID : String
    private var _countryTitle : String
    private var _countryCaption : String
    private var _countryBody : String
    private var _countryImage : String
    
    var countryID: String {
        return _countryID
    }
    
    var countryTitle: String {
        return _countryTitle
    }
    
    var countryCaption: String {
        return _countryCaption
    }
    
    var countryBody: String {
        return _countryBody
    }
    
    var countryImage: String {
        return _countryImage
    }
    
    init(id: String, title: String, caption: String, body: String, image: String) {
        self._countryID = id
        self._countryTitle = title
        self._countryCaption = caption
        self._countryBody = body
        self._countryImage = image
    }
    
}
