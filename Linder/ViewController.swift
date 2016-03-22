//
//  ViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/14/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    var lawyers: NSArray = NSArray()
    var currentLawyer: String?
    {
        get
        {
            return _currentLawyer
        }
        set
        {
            _currentLawyer = newValue
            print("setting headshot")
            let imageData: NSData = NSData(contentsOfURL: NSURL(string: _currentLawyer!)!)!
            print("loaded data")
            self.imageView.image = UIImage(data: imageData)
            self.imageView.setNeedsDisplay()
            self.view.setNeedsDisplay()
        }
    }
    
    var currentLocation: CLLocation?
    {
        get
        {
            return _currentLocation
        }
        set
        {
            _currentLocation = newValue
        }
    }
    
    var locationManager:CLLocationManager = CLLocationManager()

    private var _currentLawyer : String?
    private var _currentLocation : CLLocation?
    
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
        print("deny the current lawyer")
    }
    
    func accept() {
        print("accept the current lawyer")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start checking location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        AvvoAPIClient.fetchLawyers({(fetchedLawyers: Array<Lawyer>) -> Void in
            self.lawyers = fetchedLawyers
        })
    }
    
    // MARK: CLLocationManagerDelegate

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let lastLocation: CLLocation = locations.last! as CLLocation
        currentLocation = lastLocation
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("auth status change")
        locationManager.startMonitoringSignificantLocationChanges()
    }

}

