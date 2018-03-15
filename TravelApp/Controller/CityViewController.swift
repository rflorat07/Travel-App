//
//  CityViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 09/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var opacityImageView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoCoverView: UIView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var spotCollectionView: UICollectionView!
    
    
    var city : [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        spotCollectionView.delegate = self
        spotCollectionView.dataSource = self
        
        loadViewData()
    }
    
    func loadViewData() {
        cityLabel.text = city["title"]
        bodyLabel.text = city["body"]
        coverImageView.image = UIImage(named: city["image"]!)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CityViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            photoCoverView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
            opacityImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
    }
}

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.photosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCollectionViewCell
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotCollectionViewCell
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Show Photo
    }
    
}
