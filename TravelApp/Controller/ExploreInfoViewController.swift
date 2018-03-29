//
//  ExploreInfoViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 28/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ExploreInfoViewController: UIViewController {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageCoverView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var city : City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        loadViewData()

    }
    
    func loadViewData() {
        bodyLabel.text = city.cityBody
        titleLabel.text = city.cityTitle
        coverImageView.image = UIImage(named: city.cityImage)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension ExploreInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            imageCoverView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            coverImageView.transform =  CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
    }
    
}










