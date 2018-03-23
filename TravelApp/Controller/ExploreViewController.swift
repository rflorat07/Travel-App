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
    
    var dataSities : [[String: String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        dataSities = cities
        
        addTapGestures()
        
    }
    
    func addTapGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAndHideKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func tapAndHideKeyboard() {
        self.view.endEditing(false)
    }
    
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "EXPLORE_FILTER", sender: nil)
    }
    
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell
        
        let city = dataSities[indexPath.row]
        
        cell.titleLabel.text = city["title"]
        cell.coverImageView.image = UIImage(named: city["image"]!)
        
        return cell
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        
        if searchText.count == 0 {
            dataSities = cities
        } else {
            dataSities = dataSities.filter {
                
                if $0["title"]?.lowercased().range(of: searchText) != nil {
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






