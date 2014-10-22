//
//  LawyerViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/17/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class LawyerViewController: UIViewController {
    
    var lawyer: Lawyer? {
        didSet {
            println("set lawyer")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}