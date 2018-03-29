//
//  MainViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 07/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MainViewController: UIViewController {
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var countriesArray = [Country]()
    
    /// animator, clipToBounds, row, column
    var  animator: (LayoutAttributesAnimator, Bool, Int, Int)!
    var  direction: UICollectionViewScrollDirection = .horizontal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        loadViewData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        changeTabBarAndStatusBarStyle(mustChange: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        changeTabBarAndStatusBarStyle(mustChange: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "COUNTRY" {
            
            let toViewController = segue.destination as! CountryViewController
            let indexPath = sender as! IndexPath
            let country = countriesArray[indexPath.row]
            
            toViewController.country = country
        }
    }
    
    
    func loadViewData() {
        
        changeTabBarAndStatusBarStyle(mustChange: true)
        
        LoadingIndicatorView.show("Loading")
        
        DataService.instance.getAllCountries { (returnedCountriesArray) in
            
            self.countriesArray = returnedCountriesArray
            self.countryCollectionView.reloadData()
            self.settingAnimatedCollectionView()
            
            LoadingIndicatorView.hide()
        }
        
    }
    
    func settingAnimatedCollectionView() {
        
        countryCollectionView?.isPagingEnabled = false
        
        animator = (LinearCardAttributesAnimator(minAlpha: 0.5, itemSpacing: 0.02, scaleRate: 1.0), false, 1, 1)
        
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = animator?.0
        layout.estimatedItemSize = CGSize( width: 259, height: 390)
        countryCollectionView.collectionViewLayout = layout
        
        if countriesArray.count > 1 {
            countryCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }

    }
    
    func changeTabBarAndStatusBarStyle( mustChange: Bool ) {
        
        if mustChange {
            
            // TabBar Style
            self.tabBarController?.tabBar.tintColor = .white
            self.tabBarController?.tabBar.clipsToBounds = true
            self.tabBarController?.tabBar.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.7137254902, blue: 0.7843137255, alpha: 1)
            self.tabBarController?.tabBar.layer.borderWidth = 0.0
            self.tabBarController?.tabBar.backgroundColor = .clear
            self.tabBarController?.tabBar.backgroundImage = UIImage()
            
            // StatusBar Style
            UIApplication.shared.statusBarStyle = .lightContent
            
        } else {
            
            // TabBar Style
            self.tabBarController?.tabBar.tintColor = .black
            self.tabBarController?.tabBar.clipsToBounds = false
            self.tabBarController?.tabBar.layer.borderWidth = 0.50
            self.tabBarController?.tabBar.backgroundColor = .white
            
            // StatusBar Style
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
        

    }
    
     @IBAction func unwindToMainViewController(segue:UIStoryboardSegue) { }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCollectionViewCell
        
        let country = countriesArray[indexPath.row]
        
        cell.clipsToBounds = animator.1
        
        cell.titleLabel.text = (country.countryTitle)
        cell.captionLabel.text = (country.countryCaption)
        cell.coverImageView.image = UIImage(named: country.countryImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "COUNTRY", sender: indexPath)
    }
    
}


