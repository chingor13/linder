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
    
    let buttonDiameter: CGFloat = 50
    let buttonHPadding: CGFloat = 80
    
    var lawyers: Array<Lawyer> = Array()
    var topCardView: UIView = UIView()
    var bottomCardView: UIView = UIView()
    var savedLawyers: Array<Lawyer> = Array()
    
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
        
        constructBackground()
        constructNopeButton()
        constructLikeButton()
    }

    // TODO: save in CoreData
    func saveLawyer(lawyer: Lawyer) -> Void {
        self.savedLawyers.append(lawyer)
    }

    // TODO: save in CoreData
    func skipLawyer(lawyer: Lawyer) -> Void {
        println("skipping lawyer")
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection) {
        let lpv = view as LawyerPickerView
        if (direction == MDCSwipeDirection.Right) {
            if(lpv.lawyer != nil) {
                saveLawyer(lpv.lawyer!)
            }
            println("Lawyer saved!")
        } else {
            if(lpv.lawyer != nil) {
                skipLawyer(lpv.lawyer!)
            }
            println("Lawyer skipped!")
        }
        
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
    
    func buttonY() -> CGFloat {
        return CGRectGetMaxY(self.bottomCardView.frame) +
            ((CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.bottomCardView.frame) - buttonDiameter) / 2)
    }
    
    func constructNopeButton() {
        let frame: CGRect = CGRectMake(
            buttonHPadding,
            buttonY(),
            buttonDiameter,
            buttonDiameter
        )
        let button: UIButton = UIButton(frame: frame)
        button.setImage(UIImage(named: "nope"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: "nopeTopCardView", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    func constructLikeButton() {
        let frame: CGRect = CGRectMake(
            CGRectGetWidth(self.view.bounds) - buttonDiameter - buttonHPadding,
            buttonY(),
            buttonDiameter,
            buttonDiameter
        )
        let button: UIButton = UIButton(frame: frame)
        button.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: "likeTopCardView", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    func nopeTopCardView() {
        self.topCardView.mdc_swipe(MDCSwipeDirection.Left)
    }
    
    func likeTopCardView() {
        self.topCardView.mdc_swipe(MDCSwipeDirection.Right)
    }
    
    func constructBackground() {
        let frownView: UIImageView = UIImageView(image: UIImage(named: "frown"))
        frownView.contentMode = UIViewContentMode.Center
        frownView.alpha = 0.5
        frownView.frame = CGRectMake(
            CGRectGetMinX(bottomCardView.frame),
            CGRectGetMinY(bottomCardView.frame),
            CGRectGetWidth(bottomCardView.frame),
            CGRectGetWidth(bottomCardView.frame)
        )
        
        let noMoreLabel: UILabel = UILabel(frame: CGRectMake(
            CGRectGetMinX(frownView.frame),
            CGRectGetMaxY(frownView.frame),
            CGRectGetWidth(frownView.frame),
            18
        ))
        noMoreLabel.font = UIFont.systemFontOfSize(20)
        noMoreLabel.alpha = 0.5
        noMoreLabel.text = "No more lawyers"
        noMoreLabel.textAlignment = NSTextAlignment.Center
        
        self.view.insertSubview(frownView, atIndex: 0)
        self.view.insertSubview(noMoreLabel, atIndex: 0)
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
        };
        
        var lpw: LawyerPickerView = LawyerPickerView(frame: frame, lawyer: lawyer, options: options)
        
        return lpw
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller: LikedLawyersTVC = segue.destinationViewController as LikedLawyersTVC
        controller.lawyers = self.savedLawyers
    }
}
