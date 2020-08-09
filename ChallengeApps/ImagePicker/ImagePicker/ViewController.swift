//
//  ViewController.swift
//  ImagePicker
//
//  Created by Sensehack on 03/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func experiment ()
    {
        print("hello experiment")
        let ncontroller = UIImagePickerController()
        self.present(ncontroller, animated: true, completion: nil)
    }
    
    @IBAction func activityView() {
        print("hello activity")
        let image = UIImage()
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
    /*
    @IBAction func activity() {
        
        print("hello activity")
        let image = UIImage()
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
 */
    
    @IBAction func alert() {
        print("hello alert")
        let alertActivity  = UIAlertController()
        
        alertActivity.title = "This is an alert title"
        alertActivity.message = "This is an alert message"
        
        
        
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            action in self.dismiss(animated: true, completion: nil)
        }
        
        alertActivity.addAction(okAction)
        self.present(alertActivity, animated: true, completion: nil)
        
    }
    
}

