//
//  ViewController.swift
//  textDelegate
//
//  Created by Sensehack on 06/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var switchTextField: UITextField!
    @IBOutlet weak var editingSwitch: UISwitch!
   
    
    
    
    let zipDelegate = ZipCodeTextFieldDelegate()
    let amountDelegate = AmountTextFieldDelegate()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.zipCodeTextField.delegate = zipDelegate
        self.amountTextField.delegate = amountDelegate
        self.switchTextField.delegate = self
        
        self.editingSwitch.setOn(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.editingSwitch.isOn
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    // MARK: Actions
    
    @IBAction func toggleTheTextEditor(sender: AnyObject) {
        
        if !(sender as! UISwitch).isOn {
            self.switchTextField.resignFirstResponder()
        }
    }

    


}

