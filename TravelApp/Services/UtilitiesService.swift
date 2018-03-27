//
//  UtilitiesService.swift
//  TravelApp
//
//  Created by Roger Florat on 26/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class UtilitiesService {
    
    static let intance = UtilitiesService()
    
    func showAlertController(title: String, message: String, vc: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}

