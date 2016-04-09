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
    @IBOutlet weak var timeDataPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func closeKeyboard(sender: AnyObject) {
        originTextField.resignFirstResponder()
        destTextField.resignFirstResponder()
    }

    @IBAction func setButton(sender: UIButton) {
        let origin = originTextField.text!
        let dest = destTextField.text!
        let time = timeDataPicker.date
        print(time)
        print("lala")
        if origin == "" || dest == ""{
            let alertController = UIAlertController(title: "Missing Inforamtion!", message:
                "Please enter your origin and destination.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
