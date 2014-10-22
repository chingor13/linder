//
//  LikedLawyersTVC.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/17/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class LikedLawyersTVC: UITableViewController, UITableViewDataSource {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LikedLawyerCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "Test"
        return cell
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}