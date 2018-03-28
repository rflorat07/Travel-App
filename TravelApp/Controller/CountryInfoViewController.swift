//
//  CountryInfoViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 08/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {
    
    @IBOutlet var animateView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var country : Country!
    var citiesArray = [City]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadViewData()
        
    }
    
    func loadViewData() {
        
        titleLabel.text = country.countryTitle
        captionLabel.text = country.countryCaption
        bodyLabel.text = country.countryBody
        
        LoadingIndicatorView.show("Loading")
        
        DataService.instance.getAllCities(forUID: country.countryID) { (returnedCitiesArray) in
            
            self.citiesArray = returnedCitiesArray
            self.collectionView.reloadData()
            
            LoadingIndicatorView.hide()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CITY_INFO" {
            let toViewController = segue.destination as! CityViewController
            toViewController.city = sender as! City
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMainViewController", sender: self)
    }
    
    
}

extension CountryInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryInfoCell", for: indexPath) as! CountryInfoCollectionViewCell
        
        let city = citiesArray[indexPath.row]
        
        cell.titleLabel.text = city.cityTitle
        cell.coverImageView.image = UIImage(named: city.cityImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CITY_INFO", sender: citiesArray[indexPath.row])
    }
    
    
}
