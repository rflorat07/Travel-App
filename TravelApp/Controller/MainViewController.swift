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
    
    /// animator, clipToBounds, row, column
    var  animator: (LayoutAttributesAnimator, Bool, Int, Int)!
    var  direction: UICollectionViewScrollDirection = .horizontal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        settingAnimatedCollectionView()
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
        self.tabBarController?.tabBar.backgroundColor = .white
        
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
    
    func settingAnimatedCollectionView() {
        
        countryCollectionView?.isPagingEnabled = false
        
        animator = (LinearCardAttributesAnimator(minAlpha: 0.5, itemSpacing: 0.02, scaleRate: 1.0), false, 1, 1)
        
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = animator?.0
        layout.estimatedItemSize = CGSize( width: 259, height: 390)
        countryCollectionView.collectionViewLayout = layout
        
        if countries.count > 1 {
            countryCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        
    }
    
    func changeTabBarAndStatusBarStyle() {
        
        // TabBar Style
        
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.clipsToBounds = true
        self.tabBarController?.tabBar.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.7137254902, blue: 0.7843137255, alpha: 1)
        self.tabBarController?.tabBar.layer.borderWidth = 0.0
        self.tabBarController?.tabBar.backgroundColor = .clear
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        
        // StatusBar Style
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
     @IBAction func unwindToMainViewController(segue:UIStoryboardSegue) { }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCollectionViewCell
        
        let country = countries[indexPath.row]
        
        cell.clipsToBounds = animator.1
        
        cell.titleLabel.text = (country["title"] as! String)
        cell.captionLabel.text = (country["caption"] as! String)
        cell.coverImageView.image = UIImage(named: country["image"]! as! String )
        
        return cell
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "COUNTRY", sender: indexPath)
    }
    
}


