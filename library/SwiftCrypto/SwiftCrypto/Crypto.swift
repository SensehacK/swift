//
//  Crypto.swift
//  SwiftCrypto
//
//  Created by Sensehack on 3/7/20.
//  Copyright © 2020 Sensehack. All rights reserved.
//
import UIKit
import Foundation
import Crypto

class Crypto: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    
    
    func shaPrint() {
        let inputString = "Hello, Kautilya"
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        print("Value printing of SHA256:",hashed)
        
        let inputString2 = "Hello, SwiftCrypto"
        let inputData2 = Data(inputString2.utf8)
        let hashed2 = SHA256.hash(data: inputData2)
        print("Value printing of SHA2562:",hashed2)
    }
}




