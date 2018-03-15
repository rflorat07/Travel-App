//
//  ActivityViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 15/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ActivityViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        
        settingsNavigationBar()
        settingsStyleButtonBar()
        
        super.viewDidLoad()
        
    }
    
    // MARK: settingsStyleButtonBar
    
    func settingsStyleButtonBar() {
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.9803921569, green: 0.1647058824, blue: 0, alpha: 1)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = #colorLiteral(red: 0.6588235294, green: 0.7137254902, blue: 0.7843137255, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 0.1960784314, green: 0.231372549, blue: 0.2705882353, alpha: 1)
        }
    }
    
    func settingsNavigationBar () {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = ActivityYouViewController(itemInfo: IndicatorInfo(title: "You"))
        
        let child_2 = ActivityYouViewController(itemInfo: IndicatorInfo(title: "Following"))
        
        return [child_1, child_2]
    }
    
}
