//
//  LawyerPickerViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/19/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit
import Foundation

class LawyerPickerViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var options: MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blueColor()
        options.nopeText = "Delete"
        
        options.onPan = {(state: MDCPanState!) -> Void in
            if (state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Left) {
                println("Let go now to delete the photo!")
            }
        };
    
        var lpw: LawyerPickerView = LawyerPickerView(frame: self.view.bounds, options: options)
        lpw.imageView.image = UIImage(named: "photo")
        self.view.addSubview(lpw)
    }
}