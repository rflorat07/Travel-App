//
//  ActivityYouViewController.swift
//  TravelApp
//
//  Created by Roger Florat on 15/03/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ActivityYouViewController: UITableViewController, IndicatorInfoProvider {
    
    let cellIdentifier = "activityYouCell"
    
    var itemInfo = IndicatorInfo(title: "View")
    
    init(itemInfo: IndicatorInfo) {
        
        self.itemInfo = itemInfo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    func loadViewData(){
        
        tableView.register(UINib(nibName: "ActivityYouTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 110
        tableView.allowsSelection = false
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:    cellIdentifier, for: indexPath) as! ActivityYouTableViewCell
        
        return cell
        
    }
    
    func contentBody() {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "XLPagerTabStrip"
        
        view.addSubview(label)
        view.backgroundColor = .white
        
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -50))
    }
    
}

