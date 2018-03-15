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
    
    var country : [String : Any]!
    var places : [[String: String]]!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadViewData()
        
    }
    
    
    func loadViewData() {
        titleLabel.text = country["title"] as? String
        captionLabel.text = country["caption"] as? String
        bodyLabel.text = country["body"] as? String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CITY_INFO" {
            let toViewController = segue.destination as! CityViewController
            toViewController.city = sender as! [String: String]
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CountryInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryInfoCell", for: indexPath) as! CountryInfoCollectionViewCell
        
        let place = places[indexPath.row]
        
        cell.titleLabel.text = place["title"]
        cell.coverImageView.image = UIImage(named: place["image"]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CITY_INFO", sender: places[indexPath.row])
    }
    
    
}
