//
//  ViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/14/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    @IBAction func swipeLeft(sender: AnyObject) {
        println("swipe left")
    }
    @IBAction func swipeRight(sender: AnyObject) {
        println("swipe right")
    }
    
    @IBAction func yesClick(sender: AnyObject) {
        println("yes click");
    }
    
    func gestureRecognizer(recognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) {
        println("recevied swipe")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

