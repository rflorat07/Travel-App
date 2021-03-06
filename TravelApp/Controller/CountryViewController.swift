//
//  CountryViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 08/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
        
    var country : Country!
    var swipeGestureRecognizer : UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewData()
        setGestureRecognizer()
    }
    
    func loadViewData() {
        titleLabel.text = country.countryTitle
        captionLabel.text = country.countryCaption
        coverImageView.image = UIImage(named: country.countryImage)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "COUNTRY_INFO" {
            let toViewController = segue.destination as! CountryInfoViewController
            
            toViewController.country = country
            //toViewController.places = country["places"] as! [[String: String]]
        }
    }
    
    
    func setGestureRecognizer() {
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(openCountryInfo))
        swipeGestureRecognizer.direction = .up
        
        coverImageView.addGestureRecognizer(swipeGestureRecognizer)
        coverImageView.isUserInteractionEnabled = true
        coverImageView.isMultipleTouchEnabled = true
    }
    
    @objc func openCountryInfo() {
        performSegue(withIdentifier: "COUNTRY_INFO", sender: country)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        
}
