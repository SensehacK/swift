//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Kautilya on 05/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import CoreData


class AddTaskViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var isImportant: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnTapped(_ sender: Any) {
        print("Button Tapped")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        

        /*
        var valid_field : Bool = true
        
        guard let txtField = textField.text , !txtField.isEmpty else {
            print("Please Enter a Task Name 1")
            valid_field = false
            showAlert(title: "Empty String", message: "Please Enter a Task Name")
            return
        }
         */
        
//        let txtField = textField.text
        if (textField.text?.isEmpty)! {
            print("Please Enter a Task Name 1")
            
            self.showAlert(title: "Empty String", message: "Please Enter a Task Name")
        }
        else {
            
            // Easy Method of class
            let ase = Tasks(context: managedContext)
            
            print("Running after Guard statement")
            print(textField.text!)
            ase.isImportant = isImportant.isOn
            ase.name = textField.text!
            
            print("In valid Field no empty String Text Field")
            // Commit the Core Data
            appDelegate.saveContext()
            //Debug Print
            print("Core Data Saved")
            
            navigationController?.pop(animated: true)
            
        }
    }

    
}


// MARK: Old implementations

// Old Methods
/*
 Warning as I wasn't catching the return type of pop view controller so , made an extension or you could just use _ =
 /Users/Kautilya/Documents/Kautilya/ProjectsP/TodoList/TodoList/AddTaskViewController.swift:67:35: Expression of type 'UIViewController?' is unused
 
 _ =  navigationController?.popViewController(animated: true)
 
 //////////////////////////////////////////////////
 
        if valid_field {
            //Setting Precommit Phase 1 Core Data
            print("Running after Guard statement")
            print(txtField)
            ase.isImportant = isImportant.isOn
            ase.name = txtField
            
            print("In valid Field no empty String Text Field")
            // Commit the Core Data
            appDelegate.saveContext()
            //Debug Print
            print("Core Data Saved")
            
            navigationController?.popViewController(animated: true)
        }
        
 
        //////////////////////////////////////////////////
        
        //Wrong method of Guard.

        guard let txtField2 = textField.text , txtField2.isEmpty else {
            print("Inside save guard core data statements")
            ase.isImportant = isImportant.isOn
            ase.name = txtField3
            // Commit the Core Data
            appDelegate.saveContext()
            //Debug Print
            print("Core Data Saved")
            navigationController?.popViewController(animated: true)
            
            return
        }
        
        print("Please Enter a Task Name 1")
        showAlert(title: "Empty String", message: "Please Enter a Task Name")
 
        //////////////////////////////////////////////////
 
        if (textField.text?.isEmpty)! {
            print("Please Enter a Task Name")
        }
        else {
            ase.isImportant = isImportant.isOn
            ase.name = textField.text
        }
 

        //////////////////////////////////////////////////

        // Extra Method without creating/generating the NSManaged classes
        let entity =
            NSEntityDescription.entity(forEntityName: "Tasks",
                                       in: managedContext)!
        
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        
 
        // Pre commit 1st Phase Core Data
        task.setValue(taskText, forKey: "name")
        task.setValue(isImportant.isOn, forKey: "isImportant")
        
        */
        
        
    
    

