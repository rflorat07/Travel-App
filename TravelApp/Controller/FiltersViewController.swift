//
//  FiltersViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 22/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var featuresCollectionView: UICollectionView!
    @IBOutlet weak var continentCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuresCollectionView.delegate = self
        featuresCollectionView.dataSource = self
        
        continentCollectionView.delegate = self
        continentCollectionView.dataSource = self
    }


    @IBAction func closeFilterButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension FiltersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == featuresCollectionView {
            return features.count
        } else {
            return continents.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.featuresCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuresCell", for: indexPath) as! FeaturesCollectionViewCell
            
            let feature = features[indexPath.row]
            
            cell.featureLabel.text = feature["option"]
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "continentCell", for: indexPath) as! ContinentCollectionViewCell
            
            let continent = continents[indexPath.row]
            
            cell.continentLabel.text = continent["option"]
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding : CGFloat = 40.0
        
        if collectionView == self.featuresCollectionView {
            
            let option = features[indexPath.row]["option"]
            let sizeOfString = option!.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0)]).width + padding
            
            return CGSize(width: sizeOfString , height: 40.0)
            
        } else {
            
            let option = continents[indexPath.row]["option"]
            let sizeOfString = option!.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0)]).width + padding
            
            return CGSize(width: sizeOfString, height: 40.0)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 8
        cell?.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.1647058824, blue: 0, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 0
    
    }

}


