//
//  LawyerViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/17/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class LawyerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var lawyer: Lawyer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.lawyer != nil) {
            self.imageView.image = lawyer!.headshot
        }
    }
}