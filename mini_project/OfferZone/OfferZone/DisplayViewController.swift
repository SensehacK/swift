//
//  ViewController.swift
//  OfferZone
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    
    
    @IBOutlet var offerDetails: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var productTF: UITextField!
    
    @IBOutlet var offerTF: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    
    
    var displayObject : Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        productTF.isHidden = true
        offerTF.isHidden = true
        displayDetails()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    func displayDetails () {
        
        if let displyObj  = displayObject {
            productName.text = displyObj.productName
            offerDetails.text = displyObj.offerName
            
            
            
            // Image Retrieval 
            
            let imagedata  = UIImage(data:displyObj.offerPhoto as! Data)
            imageView.image = imagedata
            
            // Date Retrieval
            let dateRetrieved = displyObj.offerDate
            
            print(type(of : dateRetrieved))
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let selectedDate = dateFormatter.string(from: dateRetrieved!)
            print(selectedDate)
            print(type(of : selectedDate))
            
            dateLabel.text = selectedDate
        
        }
        
        
        
    }

    @IBAction func edit(_ sender: Any) {
    print("AGawe")
        print("////////////////////////////")
    
    }
    
    @IBAction func backB(_ sender: Any) {
        
        print("back button")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        print("Edit Button Pressed")
        
        
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        print("Back button Pressed")
        
        _ = navigationController?.popViewController(animated: true)
        
        
        
        
    }

}

