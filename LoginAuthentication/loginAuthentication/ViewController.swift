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
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        statusLabel.text = "Login Button Pressed"
    }

    @IBAction func touchIDAction(_ sender: Any) {
        print("Hello Sensehack")
        let myContext = LAContext()
        let myLocAuthStr = "Biometric Authentication test!"
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            // deviceOwnerAuthentication used parallely with Passcode or
            // just want Touch ID then use deviceOwnerAuthenticationWithBiometrics
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocAuthStr) { success, error
                    in
                    DispatchQueue.main.async {
                        if success {
                            // user authenticated
                            print("Authenticated successfully")
                            self.statusLabel.text = "Authenticated successfully"
                            self.view.backgroundColor = UIColor.green
                        } else {
                            // user not authenticated
                            print("not authenticated")
                            self.statusLabel.text = "not authenticated"
                            self.view.backgroundColor = UIColor.red
                            print("Printing error if any")
                            print(error!)
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

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
