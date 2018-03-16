//
//  ProfileViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 15/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverProfileView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tripsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        tripsCollectionView.delegate = self
        tripsCollectionView.dataSource = self
    }
    
    
    
}

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
 
        if offsetY < 0 {
            coverProfileView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        } 
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileTripsCell", for: indexPath) as! ProfileTripsCollectionViewCell
        let trip = trips[indexPath.row]
        
        cell.titleLabel.text = trip["title"]
        cell.coverImageView.image = UIImage(named: trip["image"]!)
        
        return cell
        
    }
    
}
