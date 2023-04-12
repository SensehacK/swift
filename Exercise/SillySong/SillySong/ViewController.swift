//
//  ViewController.swift
//  SillySong
//
//  Created by Kautilya on 30/03/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var lyricsField: UITextView!
    
    
    //Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Adding the delegate for keyboard.
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
    }
    
    
    @IBAction func displayLyrics(_ sender: Any) {
        
        guard  (nameField.text?.isEmpty)! else  {
            let nameEntered = nameField.text
            let lyricsToBeDisplayed = lyricsForName(lyricsTemplate: bananaFanaTemplate , fullName: nameEntered!)
            lyricsField.text = lyricsToBeDisplayed
            return
        }
        //Print Debug prints
        print("Name Field is Empty")
    }
}


// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
