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
        
        self.tabBarController?.tabBar.tintColor = .black
        self.tabBarController?.tabBar.clipsToBounds = false
        self.tabBarController?.tabBar.layer.borderWidth = 0.50
        
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
        
        // TabBar Style
        
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.clipsToBounds = true
        self.tabBarController?.tabBar.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.7137254902, blue: 0.7843137255, alpha: 1)
        self.tabBarController?.tabBar.layer.borderWidth = 0.0
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        
        // StatusBar Style
        
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
