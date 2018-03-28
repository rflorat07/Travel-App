//
//  Posts.swift
//  TravelApp
//
//  Created by Roger Florat on 28/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class Post {
    
    private var _postsName : String
    private var _postsAvatar : String
    private var _postsCaption : String
    private var _postsBody : String
    private var _postsImage : String
    
    var postsName: String {
        return _postsName
    }
    
    var postsAvatar: String {
        return _postsAvatar
    }
    
    var postsCaption: String {
        return _postsCaption
    }
    
    var postsBody: String {
        return _postsBody
    }
    
    var postsImage: String {
        return _postsImage
    }
    
    init( name: String, avatar: String, caption: String, body: String, image: String) {
        self._postsName = name
        self._postsAvatar = avatar
        self._postsCaption = caption
        self._postsBody = body
        self._postsImage = image
    }
    
}
