//
//  DriverSetViewController.swift
//  PickMeUp
//
//  Created by Yan Lu on 16/4/9.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit

class DriverSetViewController: UIViewController {
    @IBOutlet weak var originTextField: UITextField!
    
    @IBOutlet weak var destTextField: UITextField!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    @IBAction func closeKeyboard(sender: AnyObject) {
        originTextField.resignFirstResponder()
        destTextField.resignFirstResponder()
    }
    @IBAction func setButton(sender: AnyObject) {
        let origin = originTextField.text!
        let dest = destTextField.text!
        let time = String(timeDatePicker.date)
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let deviceToken = delegate.TOKEN
        let para:NSMutableDictionary = NSMutableDictionary()



        if origin == "" || dest == ""{
            let alertController = UIAlertController(title: "Missing Inforamtion!", message:
                "Please enter your origin and destination.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            para.setValue("1-206-619-6104", forKey: "phone")
            para.setValue(time, forKey: "time")
            para.setValue(dest, forKey: "dest")
            para.setValue(origin, forKey: "source")
            para.setValue("Yazhuo", forKey: "user")
            para.setValue(deviceToken, forKey: "driver_token")
            let jsonData = try! NSJSONSerialization.dataWithJSONObject(para, options: NSJSONWritingOptions())
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as! String
            httpPost(jsonString)
        }

        
        
        
    }
    
    
    func httpPost(command:String){
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://52.207.233.22:5000/postdriver")!); request.HTTPMethod = "POST"
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
