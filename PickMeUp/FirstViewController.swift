//
//  FirstViewController.swift
//  PickMeUp
//
//  Created by Yan Lu on 16/4/8.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {
    var locationManager = CLLocationManager()
    @IBOutlet weak var clientMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let regionRadius: CLLocationDistance = 100
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            clientMapView.setRegion(coordinateRegion, animated: true)
            centerMapOnLocation(initialLocation)

        }

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            clientMapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }


}

