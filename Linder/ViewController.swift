//
//  ViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/14/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    @IBAction func swipeLeft(sender: AnyObject) {
        deny()
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        accept()
    }
    
    @IBAction func yesClick(sender: AnyObject) {
        accept()
    }
    
    @IBAction func noClick(sender: AnyObject) {
        deny()
    }
    
    func deny() {
        println("deny the current lawyer")
    }
    
    func accept() {
        println("accept the current lawyer")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AvvoAPIClient.fetchLawyers({(lawyers: NSArray) -> Void in
            for lawyer: AnyObject in lawyers {
                if let headshotUrl = lawyer["headshot_url"] as? String {
                    var firstname = lawyer["firstname"],
                    lastname = lawyer["lastname"]
                    println("Got lawyer: \(firstname) \(lastname)")
                    println(headshotUrl)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

