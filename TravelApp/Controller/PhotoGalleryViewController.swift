//
//  PhotoGalleryViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 29/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    var imageToShow : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 3.0
        
        UIApplication.shared.isStatusBarHidden = true
        
        tapGestureRecognizer()
        
        image.image = UIImage(named: imageToShow)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func tapGestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoGalleryViewController.zoom))
        
        tap.numberOfTapsRequired = 2
        
        scrollView.addGestureRecognizer(tap)
    }
    
    @objc func zoom(sender: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale < 1.5) {
            
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
            
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
