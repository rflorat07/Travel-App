//
//  ProfileViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 15/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverProfileView: UIView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tripsCollectionView: UICollectionView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        tripsCollectionView.delegate = self
        tripsCollectionView.dataSource = self
        
        loadViewData()
        
    }
    
    func loadViewData() {
        
        let userInfo = DataService.instance.USER_INFO
        
        self.nameLabel.text = userInfo.userName
        self.cityLabel.text = userInfo.userCity
        self.avatarImageView.kf.setImage(with: URL(string: userInfo.userAvatar))
        self.avatarImageView.kf.indicatorType = .activity
    }
    
    @IBAction func profileEditButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "PROFILE_EDIT", sender:nil )
    }
    
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            
            LoadingIndicatorView.show("Loading")
            
            do {
                try Auth.auth().signOut()
                
                let splashVC = self.storyboard?.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController
                
                splashVC?.modalPresentationStyle = .overFullScreen
                splashVC?.modalTransitionStyle = .crossDissolve
                
                LoadingIndicatorView.hide()
                
                self.present(splashVC!, animated: true, completion: nil)
                
            } catch {
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        logoutPopup.addAction(cancelAction)
        logoutPopup.addAction(logoutAction)
        
        self.present(logoutPopup, animated: true, completion: nil)
    }
    
    
}

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            avatarView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            navTitleLabel.transform = CGAffineTransform(translationX: 0, y: offsetY)
            signOutButton.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverProfileView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/10)
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
