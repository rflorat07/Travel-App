//
//  ActivityYouTableViewCell.swift
//  TravelApp
//
//  Created by Roger Florat on 15/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ActivityYouTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
