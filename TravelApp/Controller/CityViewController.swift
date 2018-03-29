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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var opacityImageView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoCoverView: UIView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var spotCollectionView: UICollectionView!
    
    
    var city : City!
    var spotsArray = [Spot]()
    
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
        
        cityLabel.text = city.cityTitle
        bodyLabel.text = city.cityBody
        coverImageView.image = UIImage(named: city.cityImage)
        
        LoadingIndicatorView.show("Loading")
        
        DataService.instance.getAllSpots { (returnedSpotsArray) in
            
            self.spotsArray = returnedSpotsArray
            
            self.spotCollectionView.reloadData()
            self.photosCollectionView.reloadData()
            
            LoadingIndicatorView.hide()
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SPOT_INFO" {
            let toViewController = segue.destination as! SpotViewController
            let indexPath = sender as! IndexPath
            let spot = spotsArray[indexPath.row]
            
            toViewController.spot = spot
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension CityViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        cityLabel.textAlignment = .left
        cityLabel.transform = CGAffineTransform(translationX: 0 , y: 0)
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 {
            
            photoCoverView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            
            coverImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
            
            opacityImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
            
        } else if offsetY > 135 {
            
            photoCoverView.transform = CGAffineTransform(translationX: 0, y: offsetY - 135)
            
            self.cityLabel.textAlignment = .center
            
        }
    }
}

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.photosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCollectionViewCell
            
            let spot = spotsArray[indexPath.row]
            
            cell.coverImageView.image = UIImage(named: spot.spotImage)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotCollectionViewCell
            
            let spot = spotsArray[indexPath.row]
            
            cell.titleLabel.text = spot.spotTitle
            cell.captionLabel.text = spot.spotCaption
            cell.coverImageView.image = UIImage(named: spot.spotImage)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.spotCollectionView {
            performSegue(withIdentifier: "SPOT_INFO", sender: indexPath)
            
        } else {
            let photoGallery = self.storyboard?.instantiateViewController(withIdentifier: "PhotoGalleryViewController") as! PhotoGalleryViewController
            
            photoGallery.imageToShow = spotsArray[indexPath.row].spotImage
            
            photoGallery.modalTransitionStyle = .crossDissolve
            photoGallery.modalPresentationStyle = .overFullScreen
            
            present(photoGallery, animated: true, completion: nil)
        }
    }
}
