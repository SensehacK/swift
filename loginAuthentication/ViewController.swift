//
//  ViewController.swift
//  loginAuthentication
//
//  Created by Kautilya on 05/02/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func touchIDAction(_ sender: Any) {
        
        print("Hello Sensehack")
        
        let myContext = LAContext()
        let myLocalizedAuthString = "Biometric Authentication test!"
        var authError : NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedAuthString) { success, evaluatreError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // user authenticated
                            
                            print("Authenticated successfully")
                            self.statusLabel.text = "Authenticated successfully"
                            
                        } else {
                            
                            // user not authenticated
                            print("not authenticated")
                            self.statusLabel.text = "not authenticated"
                        }
                    }
                    
                }
            } else {
                // couldnt evaluate policy
                print("couldn't evaluate policy")
                self.statusLabel.text = "couldn't evaluate policy"
                
            }
        } else {
            
            print("feature not supported iOS version less than 8")
            self.statusLabel.text = "feature not supported iOS version less than 8"
        }
    }
    
    
}

