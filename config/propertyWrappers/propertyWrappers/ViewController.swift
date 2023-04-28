//
//  ViewController.swift
//  propertyWrappers
//
//  Created by Kautilya Save on 4/28/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let whiteSpaceExample = "https://sensehack.github.io "
        let newLineWhiteSpaceExample = """
                              
                              https://sensehack.github.io
                              
                              
                              """
        print(whiteSpaceExample + "Wassup")
        print(newLineWhiteSpaceExample + "Wassup")
        @Trimmed var trimmedWhiteSpace = whiteSpaceExample
        @Trimmed var trimmedNewLineWhiteSpace = newLineWhiteSpaceExample
        
        print(trimmedWhiteSpace + "white space")
        print(trimmedNewLineWhiteSpace + "white space new line")
    }


}

/// This will returned a trimmed string eliminating whitespace and newlines spaces
@propertyWrapper
public struct Trimmed {
    var value: String
    
    
    public init(wrappedValue: String) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: String {
        get {
            value.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
            value = newValue
        }
    }
    
}
