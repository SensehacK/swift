//
//  ViewController.swift
//  SleepingInTheLibrary
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var grabImageButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func grabNewImage(_ sender: AnyObject) {
        setUIEnabled(false)
        getImageFromFlickr()
        let escapedString = escapedParameters(testurl as [String : AnyObject])
        
        print(escapedString)
    }
    
    
    let testurl = [ "course" : "networking" , "nanodegree":"ios", "quiz" : "escaping parameters"]

    
    // MARK: Configure UI
    
    fileprivate func setUIEnabled(_ enabled: Bool) {
        photoTitleLabel.isEnabled = enabled
        grabImageButton.isEnabled = enabled
        
        if enabled {
            grabImageButton.alpha = 1.0
        } else {
            grabImageButton.alpha = 0.5
        }
    }
    
    // MARK: Make Network Request
    
    private func getImageFromFlickr() {
        
        // TODO: Write the network code here!
        
        let methodParameters = [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.GalleryPhotosMethod,
            Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.GalleryID: Constants.FlickrParameterValues.GalleryID,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
        ]
        
        let urlString = Constants.Flickr.APIBaseURL + escapedParameters(methodParameters as [String:AnyObject])
       
        // easy understanding concepts & printing them for proper understanding
        print(escapedParameters(methodParameters as [String : AnyObject]))
        print("Easy understanding")
        print(urlString)
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                }
            }
            
             //Guard statement Was there any error.
            guard error == nil else {
                displayError("Error is been thrown: \(error) ")
                return
                
            }
            
            // Guard statement Status Return check OK ? 
            
            guard let statusCode  = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Return Status Code different from Range 200 .... 299")
                return
            }
            
            //optional data binding
            guard let data = data else {
                displayError("Data is not present , optional checking failed")
                return
            }
            
            
                    let parsedResult : [String:AnyObject]!
                    
                    do {
                    parsedResult   = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                    } catch
                    {
                        displayError("couldn't parse the json data '\(data)' ")
                        return
                    }
                    print(parsedResult)
            
            
            // Guard Statement
            
                guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String, stat == Constants.FlickrResponseValues.OKStatus
                    else {
                        displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
                        return
                        }
            
                //guard statement
                    guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject],
                        let photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]]
                        else {
                            displayError("Cannot find keys")
                            return
                        }
            
                        
                        //print(photoArray[0])
                            
                        let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                            let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
                            print( " URL & Title PRinting next")
            
                    //Guard statement
                        guard let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String ,
                                let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
                            else {
                                displayError("ImageURL string couldn't set it with Flickr Response keys")
                                return
                                }
                        
            
                                print(imageUrlString)
                                print(photoTitle)
                                
                                
                                let imageURL = URL(string : imageUrlString)
                                if let imageData = try? Data(contentsOf :imageURL!) {
                                    performUIUpdatesOnMain{
                                        self.photoImageView.image  = UIImage(data: imageData)
                                        self.photoTitleLabel.text  = photoTitle
                                        self.setUIEnabled(true)
                                    }

                }
                
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
    
    
}
