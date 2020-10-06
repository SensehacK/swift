//
//  ZipCodeTextFieldDelegate.swift
//  textDelegate
//
//  Created by Sensehack on 06/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//


import Foundation
import UIKit

class ZipCodeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChanKautilyaharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        var newText = textField.text! as NSString
        newText  = newText.replacingCharacters(in: range, with: string) as NSString
        
        
        
        return newText.length <= 5
    }
    
}
