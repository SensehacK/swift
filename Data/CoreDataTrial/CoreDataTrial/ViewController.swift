//
//  ViewController.swift
//  CoreDataTrial
//
//  Created by Kautilya on 04/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var usernameArr = [String] ()
    var passwordArr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Create Context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        // MARK: Store Data in Core Data
        
        /*
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("rdrwe", forKey: "username")
        newUser.setValue("w2wdw", forKey: "password")
        
        do {
            try context.save()
            print("Saved")
        }
        catch {
            print("Couldn't process core data")
        }
        */
        
        
        
        // MARK: Fetch Core Data usernames & passwords
        
                let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let username = result.value(forKey: "username") as? String
                    {
                        print("username")
                        print(username)
                        usernameArr.append(username)
                    }
                    
                    if let password = result.value(forKey: "password") as? String
                    {
                        print("password")
                        print(password)
                        passwordArr.append(password)
                    }
                }
                
                print(usernameArr)
                print(passwordArr)
            }
        }
        catch {
            print("Process error")
        }
        
       
        
        
        
        //MARK: Appending the String with an extra character
        /*
        let coredataRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Users")
        
        do {
            let results = try context.fetch(coredataRequest)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject]
                {
                    if let usernameRetr = result.value(forKey: "username") as? String
                    {
                        result.setValue("$" + usernameRetr, forKey: "username")
                        
                        // Saving context using do catch core data
                        
                        do {
                            try context.save()
                        }
                        catch {
                            print("Couldn't save the new update , string interpolation $")
                        }
                        
                    }
                }
                
                
            }
            else {
                print("No records found in Core Data")
            }
            
            
        }
        catch {
            print("coredata processing error")
        }
        */
        
        // MARK: Specific elements to be changed
        /*
        let requestCoreData = NSFetchRequest<NSFetchRequestResult>(entityName : "Users")
        
        do {
            let results = try context.fetch(requestCoreData)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let resultUser = result.value(forKey: "username") as? String {
                        if resultUser == "$Kautilya$" {
                            print("Found the m@$@er F$@%ing Genius")
                            
                            result.setValue("Genius/Idiot", forKey: "username")
                            
                            
                            do {
                                try context.save()
                            }
                            catch {
                                print("error while saving the genius")
                            }
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            else {
                print("No data returned , Empty Core Data")
            }
            
            
        }
        
        catch {
            print("error in fetching core data")
        }
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

