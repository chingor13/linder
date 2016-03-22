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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, lawyer: Lawyer, options: MDCSwipeToChooseViewOptions) {
        super.init(frame: frame, options: options)
        
        self.lawyer = lawyer
        
        // Setup resizing masks
        self.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleBottomMargin]
        
        self.imageView.autoresizingMask = self.autoresizingMask
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.imageView.frame = CGRectMake(
            2,
            2,
            CGRectGetWidth(self.bounds) - 4,
            CGRectGetHeight(self.bounds) - 4
        )
        
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
        infoView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin];
        
        self.addSubview(infoView)
        
        constructNameLabel()
    }
    
    func loadImageView() {
        self.imageView.image = self.lawyer?.headshot
    }
    
    func constructNameLabel() {
//        let nameLabelFrame = CGRectMake(
//            5,
//            5,
//            CGRectGetWidth(infoView.bounds),
//            18
//        )

        let nameLabel: UILabel = UILabel(frame: infoView.bounds)
        nameLabel.text = "\(lawyer!.firstname) \(lawyer!.lastname)"
        nameLabel.textAlignment = NSTextAlignment.Center
        //nameLabel.textRectForBounds(nameLabel.bounds, limitedToNumberOfLines: 1)
        nameLabel.font = UIFont.systemFontOfSize(20.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        infoView.addSubview(nameLabel)
    }
}
