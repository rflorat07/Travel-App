//
//  ProfileEditViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 22/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var avatarImageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tripsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        tripsCollectionView.delegate = self
        tripsCollectionView.dataSource = self
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileEditViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            coverView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
            avatarImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
    }
}

extension ProfileEditViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripsCell", for: indexPath) as! TripsCollectionViewCell
        
        return cell
    }
    
}




