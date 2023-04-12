//
//  ViewController.swift
//  UserDefaults
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var loginL: UILabel!
    @IBOutlet var nameL: UILabel!
    @IBOutlet var passL: UILabel!
    
    @IBOutlet var usernameTF: UITextField!
    
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var userDefaultuser: UILabel!
    
    @IBOutlet var directLog: UIButton!
    
    @IBOutlet var logout: UIButton!
    
    @IBOutlet var login: UIButton!
    let userDictionary = ["naem" : "kas" , "naresh" : "zxcv" , "alo" : "mnb"]
    
    var usernameold = "kautilya"
    var passwordold = "qwerty"
    var loggedIn : Bool  = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        directLog.isHidden = true
        directLog.isEnabled = false
        userDefaultuser.isHidden = true
        login.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let x = UserDefaults.standard.object(forKey: "login") as? Bool {
            if x {
                print("already logged")
                let usernameold2 = UserDefaults.standard.object(forKey: "username") as! String
                userDefaultuser.text = "Welcome Back \(usernameold2)! "
                usernameTF.isHidden = true
                passwordTF.isHidden = true
                userDefaultuser.isHidden = false
                directLog.isHidden = false
                directLog.isEnabled = true
                loginL.isHidden = true
                nameL.isHidden = true
                passL.isHidden = true
                login.isHidden = true
                logout.isHidden = false
            } else {
                print("Not logged")
                usernameTF.isHidden = false
                passwordTF.isHidden = false
                userDefaultuser.isHidden = true
                directLog.isHidden = true
                directLog.isEnabled = false
                logout.isHidden = true
                loginL.isHidden = false
                nameL.isHidden = false
                passL.isHidden = false
                login.isHidden = false
            }
        }
    }

    @IBAction func directLoginPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    

    @IBAction func login(_ sender: Any) {
        
        guard let username = usernameTF.text else {
            showAlert(title: "Please Enter Username", message: "Empty Text Field")
            return
        }
        guard let password = passwordTF.text else {
            showAlert(title: "Please Enter password", message: "Empty Text Field")
            return
        }
        
        if password.isEmpty || username.isEmpty{
            showAlert(title: "Please Enter Details", message: "Empty Text Field")
        }
//        let password = passwordTF.text
        
  
        for (user, pass) in userDictionary {
            
            if user == username && pass == password {
                print("In dictionary if else")
                loggedIn = true
 
                print("Password Accepted")
                print("SAve the password")

                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.set(loggedIn, forKey: "login")
                performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        print("Wrong password")

    }

    
    @IBAction func logoutPressed(_ sender: Any) {
        print("logout pressed")
        
        UserDefaults.standard.set(false, forKey: "login")
        usernameTF.isHidden = false
        passwordTF.isHidden = false
        userDefaultuser.isHidden = true
        directLog.isHidden = true
        directLog.isEnabled = false
        logout.isHidden = true
        loginL.isHidden = false
        nameL.isHidden = false
        passL.isHidden = false
        login.isHidden = false
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            
            print("Hello")
            
            
        }
    }
    
    func showAlert(title : String , message: String) {
        let alertDisplay = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let pressOK = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertDisplay.addAction(pressOK)
        present(alertDisplay, animated: true, completion: nil)
    }

    
    /*
        if let x = UserDefaults.standard.object(forKey: "login") as? Bool {
        if x { print("already logged") } else { print("not logged") }
        let usernameold2 = UserDefaults.standard.object(forKey: "username") as! String
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(loggedIn, forKey: "login")

     */
    
}



