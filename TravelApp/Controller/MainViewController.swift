//
//  MainViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 07/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        changeTabBarAndStatusBarStyle()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        changeTabBarAndStatusBarStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UITabBar.appearance().tintColor = nil
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "COUNTRY" {
            
            let toViewController = segue.destination as! CountryViewController
            let indexPath = sender as! IndexPath
            let country = countries[indexPath.row]
            
            toViewController.country = country
        }
    }
    
    func changeTabBarAndStatusBarStyle() {
        
        // Tab Bar changes the selected color
        
        //UITabBar.appearance().tintColor = .white
        //UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        // Status Bar Style
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCollectionViewCell
        
        let country = countries[indexPath.row]
        
        cell.titleLabel.text = (country["title"] as! String)
        cell.captionLabel.text = (country["caption"] as! String)
        cell.coverImageView.image = UIImage(named: country["image"]! as! String )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "COUNTRY", sender: indexPath)
    }
    
}
