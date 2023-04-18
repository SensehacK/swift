//
//  AnotherMainViewController.swift
//  combine-uikit
//
//  Created by Kautilya Save on 4/18/23.
//

import UIKit
import Combine

class AnotherMainViewController : ViewController, UITextFieldDelegate {
    
    @IBOutlet weak var acceptSwitch: UISwitch!
    @IBOutlet weak var privacySwitch: UISwitch!
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    // Publishers
    @Published var acceptedTerms = false
    @Published var acceptedPrivacy = false
    @Published var name = ""
    
    private var buttonSubscriber: AnyCancellable?
    
    private var validToSubmit: AnyPublisher<Bool, Never> {
        
        return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
            .map { terms, privacy, name in
                return terms && privacy && !name.isEmpty
            }
            .eraseToAnyPublisher()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namefield.delegate = self
        acceptSwitch.isOn = acceptedTerms
        privacySwitch.isOn = acceptedPrivacy
        
        buttonSubscriber = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled , on: submitButton)
        
    }
    
    
    
    @IBAction func acceptTerms(_ sender: UISwitch) {
        acceptedTerms = sender.isOn
        print(" Button pressed")
    }
    
    @IBAction func acceptPrivacy(_ sender: UISwitch) {
        acceptedPrivacy = sender.isOn
    }
    
    
    @IBAction func nameChanged(_ sender: UITextField) {
        name = sender.text ?? ""
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
