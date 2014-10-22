//
//  LawyerPickerView.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/19/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class LawyerPickerView : MDCSwipeToChooseView {
    var lawyer: Lawyer?
    var infoView: UIView = UIView()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, lawyer: Lawyer, options: MDCSwipeToChooseViewOptions) {
        super.init(frame: frame, options: options)
        
        self.lawyer = lawyer
        
        // Setup resizing masks
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight |
            UIViewAutoresizing.FlexibleWidth |
            UIViewAutoresizing.FlexibleBottomMargin
        self.imageView.autoresizingMask = self.autoresizingMask
        
        constructInfoView()
        loadImageView()
    }
    
    func constructInfoView() {
        let infoViewHeight: CGFloat = 60
        
        let infoViewFrame: CGRect = CGRectMake(
            0,
            CGRectGetHeight(self.bounds) - infoViewHeight,
            CGRectGetWidth(self.bounds),
            infoViewHeight
        )
        
        infoView = UIView(frame: infoViewFrame)
        infoView.backgroundColor = UIColor.whiteColor()
        infoView.clipsToBounds = true
        infoView.autoresizingMask = UIViewAutoresizing.FlexibleWidth |
            UIViewAutoresizing.FlexibleTopMargin;
        
        self.addSubview(infoView)
        
        constructNameLabel()
    }
    
    func loadImageView() {
        let imageData: NSData = NSData(contentsOfURL: NSURL(string: self.lawyer!.headshotUrl)!)!
        self.imageView.image = UIImage(data: imageData)
    }
    
    func constructNameLabel() {
        let nameLabelFrame = CGRectMake(
            5,
            5,
            CGRectGetWidth(infoView.bounds),
            18
        )

        let nameLabel: UILabel = UILabel(frame: nameLabelFrame)
        nameLabel.text = "\(lawyer!.firstname) \(lawyer!.lastname)"
        
        infoView.addSubview(nameLabel)
    }
}
