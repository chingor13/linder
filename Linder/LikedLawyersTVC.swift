//
//  LikedLawyersTVC.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/17/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class LikedLawyersTVC: UITableViewController, UITableViewDataSource {
    
    var lawyers: Array<Lawyer> = Array() {
        didSet {
            println("set lawyers")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LikedLawyerCell", forIndexPath: indexPath) as UITableViewCell
                                
        let lawyer = lawyerForIndexPath(indexPath)
        cell.textLabel!.text = lawyer.fullname()
        return cell
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return lawyers.count
    }
    
    func lawyerForIndexPath(indexPath: NSIndexPath) -> Lawyer {
        return lawyers[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller: LawyerViewController = segue.destinationViewController as LawyerViewController
        let lawyer = lawyerForIndexPath(self.tableView.indexPathForSelectedRow()!)
        controller.lawyer = lawyer
        controller.title = lawyer.fullname()
    }
}