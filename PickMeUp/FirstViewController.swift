//
//  FirstViewController.swift
//  PickMeUp
//
//  Created by Yan Lu on 16/4/9.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit
import GoogleMaps
class FirstViewController: UIViewController  {
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var pickDatePicker: UIDatePicker!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var Lat: String?
    var Lng: String?
    override func viewDidLoad() {
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

extension FirstViewController: CLLocationManagerDelegate {
    // 2
    @IBAction func goButton(sender: AnyObject) {
        destinationTextField.resignFirstResponder()
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let tasks = NSMutableArray()
        let tableRow = DDBClient();
        let time = String(pickDatePicker.date)
        let para:NSMutableDictionary = NSMutableDictionary()
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let deviceToken = delegate.TOKEN
        para.setValue(Lat, forKey: "Lat")
        para.setValue(Lng, forKey: "Lng")
        para.setValue("1-347-365-0427", forKey: "phone")
        para.setValue(time, forKey: "time")
        para.setValue(destinationTextField.text, forKey: "dest")
        para.setValue(sourceTextField.text, forKey: "source")
        para.setValue(deviceToken, forKey: "client_token")
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(para, options: NSJSONWritingOptions())
        let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as! String
        
        httpPost(jsonString)
        tasks.addObject(dynamoDBObjectMapper.save(tableRow))
        
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            let currLocation:CLLocation = locations.last!
            Lng = String(currLocation.coordinate.longitude)
            Lat = String(currLocation.coordinate.latitude)
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
//            locationManager.stopUpdatingLocation()
        }
        
    }

    
    
    
    func httpPost(command:String){
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://52.207.233.22:5000/postclient")!); request.HTTPMethod = "POST"
        let postString = command
        //Show the message sent to PI on IOS device
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)

        print(request.HTTPBody)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in if error != nil {
                print("error=\(error)")
                return}
            print("response = \(response)")
            let responseString = NSString(data: data!, encoding:
                NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
    
    
    
}

