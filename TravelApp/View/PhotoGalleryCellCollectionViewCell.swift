//
//  PhotoGalleryCellCollectionViewCell.swift
//  TravelApp
//
//  Created by Roger Florat on 29/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class PhotoGalleryCellCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 3.0
        
        tapGestureRecognizer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func tapGestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoGalleryCellCollectionViewCell.zoom))
        
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

}
