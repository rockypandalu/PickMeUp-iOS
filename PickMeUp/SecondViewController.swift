//
//  SecondViewController.swift
//  PickMeUp
//
//  Created by Yan Lu on 16/4/9.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit
import GoogleMaps
class SecondViewController: UIViewController {

    @IBOutlet weak var DriverMapView: GMSMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SecondViewController: CLLocationManagerDelegate {
    // 2

    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            DriverMapView.myLocationEnabled = true
            DriverMapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            let currLocation:CLLocation = locations.last!
//            Lng = String(currLocation.coordinate.longitude)
//            Lat = String(currLocation.coordinate.latitude)
            // 7
            DriverMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
//            locationManager.stopUpdatingLocation()
        }
        
    }
    
    
    
    

    
    
    
    
}

