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
    
    var postsArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewData()
    }
    
    func loadViewData() {
        
        newsPhotoCollectionView.delegate = self
        newsPhotoCollectionView.dataSource = self
        
        LoadingIndicatorView.show("Loading")
        
        DataService.instance.getAllPosts { (returnedPostsArray) in
            
            self.postsArray = returnedPostsArray
            self.newsPhotoCollectionView.reloadData()
            
            LoadingIndicatorView.hide()
        }
        
    }
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsPhotoCell", for: indexPath) as! NewsPhotoCollectionViewCell
        
        let post = postsArray[indexPath.row]
        
        cell.nameLabel.text = post.postsName
        cell.avatarImageView.image = UIImage(named: post.postsAvatar)
        cell.captionLabel.text = post.postsCaption
        cell.bodyLabel.text = post.postsBody
        cell.coverImageView.image = UIImage(named: post.postsImage)
        
        return cell
        
    }
        
}


