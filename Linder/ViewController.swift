//
//  ViewController.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/14/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    var lawyers: NSArray = NSArray()
    var currentLawyer: String?
    var locationManager:CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?

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
        
        // start checking location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        AvvoAPIClient.fetchLawyers({(fetchedLawyers: Array<Lawyer>) -> Void in
            self.lawyers = fetchedLawyers
        })
    }

    func setCurrentLawyer(headshotUrl: String) {
        self.currentLawyer = headshotUrl
        println("setting headshot")
        let imageData: NSData = NSData(contentsOfURL: NSURL(string: headshotUrl)!)!
        println("loaded data")
        self.imageView.image = UIImage(data: imageData)
        self.imageView.setNeedsDisplay()
        self.view.setNeedsDisplay()
    }
    
    func setCurrentLocation(location: CLLocation) {
        self.currentLocation = location
        println("setting location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        let lastLocation: CLLocation = locations.last as CLLocation
        setCurrentLocation(lastLocation)
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("auth status change")
        locationManager.startMonitoringSignificantLocationChanges()
    }

}

