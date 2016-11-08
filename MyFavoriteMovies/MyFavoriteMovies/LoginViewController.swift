//
//  LoginViewController.swift
//  MyFavoriteMovies
//
//  Created by Jarrod Parkes on 1/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - LoginViewController: UIViewController

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    var appDelegate: AppDelegate!
    var keyboardOnScreen = false
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
        
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the app delegate
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate                        
        
        configureUI()
        
        subscribeToNotification(UIKeyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIKeyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIKeyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIKeyboardDidHideNotification, selector: #selector(keyboardDidHide))
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    // MARK: Login
    
    @IBAction func loginPressed(sender: AnyObject) {
        
        userDidTapView(self)
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {
            setUIEnabled(false)
            
            /*
                Steps for Authentication...
                https://www.themoviedb.org/documentation/api/sessions
                
                Step 1: Create a request token
                Step 2: Ask the user for permission via the API ("login")
                Step 3: Create a session ID
                
                Extra Steps...
                Step 4: Get the user id ;)
                Step 5: Go to the next view!            
            */
            getRequestToken()
        }
    }
    
    private func completeLogin() {
        performUIUpdatesOnMain {
            self.debugTextLabel.text = ""
            self.setUIEnabled(true)
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MoviesTabBarController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // MARK: TheMovieDB
    
    private func getRequestToken() {
        
        /* TASK: Get a request token, then store it (appDelegate.requestToken) and login with the token */
        
        /* 1. Set the parameters */
        let methodParameters = [
            Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey
        ]
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/authentication/token/new"))
        
        /* 4. Make the request */
        let task = appDelegate.sharedSession.dataTaskWithRequest(request) { (data, response, error) in
            
            func displayError(error : String)
            {
                print(error)
                performUIUpdatesOnMain{
                    self.setUIEnabled(false)
                    self.debugTextLabel.text = "Login Failed (Request Token )"
                }
            }
            
            
            //Guard statement Was there any error.
            guard error == nil else {
                displayError("Error is been thrown: \(error) ")
                return
                
            }
            
            // Guard statement Status Return check OK ?
            
            guard let statusCode  = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Return Status Code different from Range 200 .... 299")
                return
            }
            
            
            
            guard let data = data  else {
                displayError("Data is not present , optional checking failed")
                return
            }
            
            
            let parsedResult : [String: AnyObject]!
            
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Did TheMovieDB return an error? */
            if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
                displayError("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
                return
            }
            
            /* GUARD: Is the "request_token" key in parsedResult? */
            guard let requestToken = parsedResult[Constants.TMDBResponseKeys.RequestToken] as? String else {
                displayError("Cannot find key '\(Constants.TMDBResponseKeys.RequestToken)' in \(parsedResult)")
                return
            }
            
            /* 6. Use the data! */
            self.appDelegate.requestToken = requestToken
            print("Request Token Key")
            print(requestToken)
            
            self.loginWithToken(self.appDelegate.requestToken!)
            
        }
        
        /* 7. Start the request */
        task.resume()
    }
    
    private func loginWithToken(requestToken: String) {
        
        /* TASK: Login, then get a session id */
        
        /* 1. Set the parameters */
        /* 2/3. Build the URL, Configure the request */
        /* 4. Make the request */
        /* 5. Parse the data */
        /* 6. Use the data! */
        /* 7. Start the request */
        
        let methodParameters : [String : String!] =  [
                                Constants.TMDBParameterKeys.ApiKey : Constants.TMDBParameterValues.ApiKey ,
                               
                                Constants.TMDBParameterKeys.Username : usernameTextField.text! ,
        
                                Constants.TMDBParameterKeys.Password : passwordTextField.text! ,
        
                                Constants.TMDBParameterKeys.RequestToken : requestToken
        
                                ]
        
        
        let request = NSURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/authentication/token/validate_with_login"))
        
        
        let task = appDelegate.sharedSession.dataTaskWithRequest(request) { (data, response , error) in
            
            func displayError(error : String)
            {
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(false)
                    self.debugTextLabel.text = "Error Occured"
                }
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                displayError("Data is not present")
                return
            }
            
            guard error == nil else {
                displayError("Error is present")
                return
                
            }
            
            
            let parsedResult : [String : AnyObject]!
            
            
            do {
             parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                displayError("JSON serialisation error present \(data)")
                return
                }
            
            
            guard let success = parsedResult[Constants.TMDBResponseKeys.Success] as? Bool  where success == true else {
                displayError("Returned status is not success")
                return
            }
            
            print("Validate request token success true or false")
            print(success)
            
            self.getSessionID(self.appDelegate.requestToken!)
            
            
        }
        
       
        task.resume()
        
    }
    
    private func getSessionID(requestToken: String) {
        
        /* TASK: Get a session ID, then store it (appDelegate.sessionID) and get the user's id */
        
        /* 1. Set the parameters */
        /* 2/3. Build the URL, Configure the request */
        /* 4. Make the request */
        /* 5. Parse the data */
        /* 6. Use the data! */
        /* 7. Start the request */
        
        let methodParameters : [String : String!] =  [
            Constants.TMDBParameterKeys.ApiKey : Constants.TMDBParameterValues.ApiKey ,
            
            Constants.TMDBParameterKeys.RequestToken : requestToken
            
        ]
        
        
        let request = NSURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/authentication/session/new"))
  
        let task = appDelegate.sharedSession.dataTaskWithRequest(request) { ( data , response , error ) in
            
            func displayError(error : String)
            {
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(false)
                    self.debugTextLabel.text = "Error Occured"
                }
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }


            guard let data = data else {
                displayError("Data is not present")
                return
            }
            
            
            guard error == nil else {
                displayError("error found \(error)")
                return
                
            }
            
            
            let parsedResult : [String:AnyObject]!
            
            do {
              parsedResult =   try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                displayError("Error catched \(data) ")
                return
            }
            
            
            
            guard let sessionID = parsedResult[Constants.TMDBResponseKeys.SessionID] as? String else {
                displayError("Session ID not found of '\(Constants.TMDBResponseKeys.SessionID)' \(parsedResult)")
                return
            }
            
            print(sessionID)
            self.appDelegate.sessionID = sessionID
            self.getUserID(self.appDelegate.sessionID!)
            
        }
    
    
    
        task.resume()
    }
    
    
    
    
    private func getUserID(sessionID: String) {
        
        /* TASK: Get the user's ID, then store it (appDelegate.userID) for future use and go to next view! */
        
        /* 1. Set the parameters */
        /* 2/3. Build the URL, Configure the request */
        /* 4. Make the request */
        /* 5. Parse the data */
        /* 6. Use the data! */
        /* 7. Start the request */
        
        let methodParameters = [
            Constants.TMDBParameterKeys.ApiKey : Constants.TMDBParameterValues.ApiKey ,
            Constants.TMDBParameterKeys.SessionID : sessionID
        
        ]
        
        let request = NSURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/account"))
        
        let task = appDelegate.sharedSession.dataTaskWithRequest(request) {( data , response ,error ) in
            
            func displayError(error : String) {
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(false)
                    self.debugTextLabel.text = "Error Occured"
                }

            }
            
            
            guard let data = data else {
                displayError("error in data")
                return
            }
            
            guard error == nil  else {
                displayError("Error is not nil \(error)")
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            let parsedResult : [String:AnyObject]!
            
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                displayError("catched error in \(data)")
                return
            }
            
            
            if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
                displayError("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
                return
            }
            
            
            guard let userID = parsedResult[Constants.TMDBResponseKeys.UserID] as? Int else {
                displayError("error couldn't find userID in \(parsedResult)")
                return
            }
            
            self.appDelegate.userID = userID
            print("UserID incoming")
            
            print(userID)
            self.completeLogin()
            
        }
        
        
        task.resume()
    }
    
    
    
    
    
    
    
    
    
}

// MARK: - LoginViewController: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardOnScreen {
            view.frame.origin.y -= keyboardHeight(notification)
            movieImageView.hidden = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardOnScreen {
            view.frame.origin.y += keyboardHeight(notification)
            movieImageView.hidden = false
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(usernameTextField)
        resignIfFirstResponder(passwordTextField)
    }
}

// MARK: - LoginViewController (Configure UI)

extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        usernameTextField.enabled = enabled
        passwordTextField.enabled = enabled
        loginButton.enabled = enabled
        debugTextLabel.text = ""
        debugTextLabel.enabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    private func configureUI() {
        
        // configure background gradient
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [Constants.UI.LoginColorTop, Constants.UI.LoginColorBottom]
        backgroundGradient.locations = [0.0, 1.0]
        backgroundGradient.frame = view.frame
        view.layer.insertSublayer(backgroundGradient, atIndex: 0)
        
        configureTextField(usernameTextField)
        configureTextField(passwordTextField)
    }
    
    private func configureTextField(textField: UITextField) {
        let textFieldPaddingViewFrame = CGRectMake(0.0, 0.0, 13.0, 0.0)
        let textFieldPaddingView = UIView(frame: textFieldPaddingViewFrame)
        textField.leftView = textFieldPaddingView
        textField.leftViewMode = .Always
        textField.backgroundColor = Constants.UI.GreyColor
        textField.textColor = Constants.UI.BlueColor
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        textField.tintColor = Constants.UI.BlueColor
        textField.delegate = self
    }
}

// MARK: - LoginViewController (Notifications)

extension LoginViewController {
    
    private func subscribeToNotification(notification: String, selector: Selector) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func unsubscribeFromAllNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
