//
//  AddFoodViewController.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import CoreData



class AddFoodViewController: UIViewController {

    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var productID: UITextField!
    
    @IBOutlet var pname: UITextField!
    
    @IBOutlet var pprice: UITextField!
    
    @IBOutlet var stepperLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    
    @IBOutlet var isVeg: UISwitch!

    @IBOutlet var submitButton: UIButton!

    @IBAction func submitButtonPr(_ sender: Any) {
        
        
        addToCoreData()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func addToCoreData () {
        
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let foodItemsObj = FoodItems(context: managedContext)
        
        
        foodItemsObj.itemID =    Int64(productID.text!)!
        foodItemsObj.itemName =     pname.text!
        foodItemsObj.itemPrice = Double(pprice.text!)!
        foodItemsObj.isVeg  = isVeg.isOn
        
        appDelegate.saveContext()
        
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



}
