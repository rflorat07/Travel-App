//
//  PhotosViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 12/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
    @IBOutlet weak var newsPhotoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsPhotoCollectionView.delegate = self
        newsPhotoCollectionView.dataSource = self
    }
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsPhotoCell", for: indexPath) as! NewsPhotoCollectionViewCell
        return cell
        
    }
}


