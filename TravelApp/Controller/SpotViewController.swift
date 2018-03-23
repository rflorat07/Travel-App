//
//  SpotViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 21/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class SpotViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var spot : [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewData()
    }

    func loadViewData() {
        titleLabel.text = spot["title"]
        bodyLabel.text = spot["body"]
        coverImageView.image = UIImage(named: spot["image"]!)
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
