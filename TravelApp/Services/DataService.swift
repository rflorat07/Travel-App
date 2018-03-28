//
//  DataService.swift
//  TravelApp
//
//  Created by Roger Florat on 26/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_SPOTS = DB_BASE.child("spots")
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_CITIES = DB_BASE.child("cities")
    private var _REF_COUNTRIES = DB_BASE.child("countries")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_SPOTS: DatabaseReference {
        return _REF_SPOTS
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_COUNTRIES: DatabaseReference {
        return _REF_COUNTRIES
    }
    
    var REF_CITIES: DatabaseReference {
        return _REF_CITIES
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getAllPosts(handler: @escaping(_ spotsArray: [Post]) -> ()) {
        
        var postsArray = [Post]()
        
        REF_POSTS.observeSingleEvent(of: .value) { (postSnapshot) in
            guard let postSnapshot = postSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for post in postSnapshot {
                
                let name = post.childSnapshot(forPath: "name").value as! String
                let avatar = post.childSnapshot(forPath: "avatar").value as! String
                let caption = post.childSnapshot(forPath: "caption").value as! String
                let body = post.childSnapshot(forPath: "body").value as! String
                let image = post.childSnapshot(forPath: "image").value as! String
                
                let post  = Post.init(name: name, avatar: avatar, caption: caption, body: body, image: image)
                
                postsArray.append(post)
                
            }
            handler(postsArray)
        }
        
    }
    
    func getAllSpots(handler: @escaping(_ spotsArray: [Spot]) -> ()) {
        
        var spotsArray = [Spot]()
        
        REF_SPOTS.observeSingleEvent(of: .value) { (spotSnapshot) in
            guard let spotSnapshot = spotSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for spot in spotSnapshot {
                
                let title   = spot.childSnapshot(forPath: "title").value as! String
                let caption = spot.childSnapshot(forPath: "caption").value as! String
                let body    = spot.childSnapshot(forPath: "body").value as! String
                let image   = spot.childSnapshot(forPath: "image").value as! String
                let spot    = Spot.init(title: title, caption: caption, body: body, image: image)
                
                spotsArray.append(spot)
                
            }
            
            handler(spotsArray)
        }
        
    }
    
    func getAllCountries(handler: @escaping (_ countriesArray: [Country]) -> ()) {
        
        var countriesArray = [Country]()
        
        REF_COUNTRIES.observeSingleEvent(of: .value) { (countrySnapshot) in
            guard let countrySnapshot = countrySnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for country in countrySnapshot {
                
                let countryID = country.key
                let title = country.childSnapshot(forPath: "title").value as! String
                let caption = country.childSnapshot(forPath: "caption").value as! String
                let body = country.childSnapshot(forPath: "body").value as! String
                let image = country.childSnapshot(forPath: "image").value as! String
                let country = Country(id: countryID, title: title, caption: caption, body: body, image: image)
                
                countriesArray.append(country)
                
            }
            
            handler(countriesArray)
        }
        
    }
    
    func getAllCities(forUID contryID: String?, handler: @escaping (_ citiesArray: [City]) -> ()) {
        
        var citiesArray = [City]()
        
        REF_CITIES.observeSingleEvent(of: .value) { (citySnapshot) in
            guard let citySnapshot = citySnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            if let contryID = contryID {
                
                for city in citySnapshot {
                    
                    let cityUID = city.childSnapshot(forPath: "uid").value as! String
                    
                    if contryID == cityUID {
                        let title = city.childSnapshot(forPath: "title").value as! String
                        let body = city.childSnapshot(forPath: "body").value as! String
                        let image = city.childSnapshot(forPath: "image").value as! String
                        let city = City(uid: cityUID, title: title, body: body, image: image)
                        
                        citiesArray.append(city)
                    }
                }
                
                
            } else {
                
                for city in citySnapshot {
                    
                    let cityUID = city.childSnapshot(forPath: "uid").value as! String
                    let title = city.childSnapshot(forPath: "title").value as! String
                    let body = city.childSnapshot(forPath: "body").value as! String
                    let image = city.childSnapshot(forPath: "image").value as! String
                    let city = City(uid: cityUID, title: title, body: body, image: image)
                    
                    citiesArray.append(city)
                }
            }
            
            handler(citiesArray)
        }
    }
    
}

extension DataService {
    
    
    /* func createNewCities() {
     
     for city in cities {
     
     let keyCity = REF_CITIES.childByAutoId()
     
     let cityData = [
     "uid": keyCity.key,
     "title": city["title"],
     "body" : city["body"],
     "image": city["image"]
     ]
     
     keyCity.updateChildValues(cityData)
     }
     
     }
     
     func createNewPosts() {
     
     for post in posts {
     
     let keyPosts = REF_POSTS.childByAutoId()
     
     let postData = [
     "name"   : post["name"],
     "avatar" : post["avatar"],
     "caption": post["caption"],
     "body"   : post["body"],
     "image"  : post["image"]
     ]
     
     keyPosts.updateChildValues(postData)
     }
     }
     
     func createNewSpots() {
     
     for spot in spots {
     
     let keySpots = REF_SPOTS.childByAutoId()
     
     let spotData = [
     "title"   : spot["title"],
     "caption" : spot["caption"],
     "body"    : spot["body"],
     "image"   : spot["image"]
     ]
     
     keySpots.updateChildValues(spotData)
     }
     }
     
     func createNewCountry() {
     
     _ = countries.map { (country) in
     
     let keyCountry = REF_COUNTRIES.childByAutoId()
     
     let countryData = [
     "title"   : country["title"],
     "caption" : country["caption"],
     "body"    : country["body"],
     "image"   : country["image"]
     ]
     
     let cities = country["places"] as! [[String: String]]
     
     _ = cities.map { ( city) in
     
     let keyCity = REF_CITIES.childByAutoId()
     
     let cityData = [
     "uid": keyCountry.key,
     "title": city["title"],
     "body" : city["body"],
     "image": city["image"]
     ]
     
     keyCity.updateChildValues(cityData)
     }
     
     keyCountry.updateChildValues(countryData)
     }
     } */
}
