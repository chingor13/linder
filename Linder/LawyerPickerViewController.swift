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
    
    var lawyers: Array<Lawyer> = Array()
    var topCardView: UIView = UIView()
    var bottomCardView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch some lawyers
        AvvoAPIClient.fetchLawyers({(fetchedLawyers: Array<Lawyer>) -> Void in
            self.lawyers = fetchedLawyers
        })
        
        // Setup initial card views
        topCardView = createLawyerView(topCardViewFrame(), lawyer: self.lawyers.removeAtIndex(0))
        self.view.addSubview(topCardView)
        
        bottomCardView = createLawyerView(bottomCardViewFrame(), lawyer: self.lawyers.removeAtIndex(0))
        self.view.insertSubview(bottomCardView, belowSubview: topCardView)
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        println("Was chosen!!!!!!!!!!!!")
        
        topCardView = bottomCardView
        
        if(self.lawyers.count > 0) {
            // Create a new bottom card view
            bottomCardView = createLawyerView(bottomCardViewFrame(), lawyer: self.lawyers.removeAtIndex(0))
            
            bottomCardView.alpha = 0.0
            self.view.insertSubview(bottomCardView, belowSubview: topCardView)
            
            UIView.animateWithDuration(
                0.5,
                delay: 0.0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: {
                    self.bottomCardView.alpha = 1
                },
                completion: nil
            )
        } else {
            bottomCardView = UIView()
        }
    }
    
    func topCardViewFrame() -> CGRect {
        let hPadding: CGFloat = 40
        let topPadding:CGFloat = 80
        let bottomPadding:CGFloat = 270
        
        return CGRectMake(
            hPadding,
            topPadding,
            CGRectGetWidth(self.view.frame) - (hPadding * 2),
            CGRectGetHeight(self.view.frame) - bottomPadding
        )
    }
    
    func bottomCardViewFrame() -> CGRect {
        let topFrame: CGRect = topCardViewFrame()
        
        return CGRectMake(
            topFrame.origin.x,
            topFrame.origin.y + 10,
            CGRectGetWidth(topFrame),
            CGRectGetHeight(topFrame)
        )
    }
    
    func createLawyerView(frame: CGRect, lawyer: Lawyer) -> LawyerPickerView {
        var options: MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blueColor()
        options.nopeText = "Delete"
        
        options.onPan = {(state: MDCPanState!) -> Void in
            let frame: CGRect = self.bottomCardViewFrame()
            self.bottomCardView.frame = CGRectMake(
                frame.origin.x,
                frame.origin.y - (state.thresholdRatio * 10.0),
                CGRectGetWidth(frame),
                CGRectGetHeight(frame)
            )
            
            //if (state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Left) {
                //println("Let go now to delete the photo!")
            //}
        };
        
        var lpw: LawyerPickerView = LawyerPickerView(frame: frame, lawyer: lawyer, options: options)
        
        return lpw
    }
}