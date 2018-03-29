//
//  ExploreViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 13/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var citiesArray = [City]()
    var searchCity  = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadViewData()
    }
    
    func loadViewData() {
        
        self.hideKeyboardWhenTappedAround()
        self.collectionView.keyboardDismissMode = .onDrag
    
        LoadingIndicatorView.show("Loading")
        DataService.instance.getAllCities(forUID: nil) { (returnedCitiesArray) in
            
            self.citiesArray = returnedCitiesArray.reversed()
            self.searchCity  = returnedCitiesArray.reversed()
            self.collectionView.reloadData()
            
            LoadingIndicatorView.hide()
            
        }
        
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "EXPLORE_FILTER", sender: nil)
    }
    
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell
        
        let city = searchCity[indexPath.row]
        
        cell.titleLabel.text = city.cityTitle
        cell.coverImageView.image = UIImage(named: city.cityImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("didSelectItemAt")
        
        let exploreInfoView = self.storyboard?.instantiateViewController(withIdentifier: "ExploreInfoViewController") as? ExploreInfoViewController
        
        exploreInfoView?.modalTransitionStyle = .crossDissolve
        exploreInfoView?.modalPresentationStyle = .overFullScreen
        
        exploreInfoView?.city = searchCity[indexPath.row]
        
        self.present(exploreInfoView!, animated: true, completion: nil)
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        
        if searchText.count == 0 {
            self.searchCity = self.citiesArray
        } else {
            self.searchCity = self.searchCity.filter {
                
                if $0.cityTitle.lowercased().range(of: searchText) != nil {
                    return true
                }
                
                return false
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(false)
    }
    
}






