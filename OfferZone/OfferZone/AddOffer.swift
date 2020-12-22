//
//  AddOffer.swift
//  OfferZone
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import  UIKit


class AddOffer : UIViewController  , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    @IBOutlet var productNTF: UITextField!
    @IBOutlet var offerNTF: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var chooseImage: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    let offerArray : [Offer] = []
    var imageSelected : UIImage = UIImage(named: "questionMark.jpg")!
    var dateTodays = Date()
    var pickedDateG = Date()
    var offerName : String = ""
    var productName : String  = ""
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        imageView.image = imageSelected
        
        print("Today's Date is : \(dateTodays)")
    }

    
    @IBAction func imageButtonPressed(_ sender: Any) {

            print("Gallery Button pressed")
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            
            let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }
                else {
                    
                    self.showAlert(title: "Not Available", message: "Camera is either broken or No Permissions granted")
                    print("Camera Not available")
                }
            }))

            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
            self.present(actionSheet, animated: true, completion: nil)
 
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageSelected = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        
        
        guard let offerText = productNTF.text?.isEmpty , offerText == false else {
            
            print("Empty Offer Text Field")
            showAlert(title: "Product Text Field Empty", message: "Please Enter the Product Name")
            
            return
        }
        
        
        guard let nameText = offerNTF.text?.isEmpty , nameText == false else {
            
            print("Empty name Text Field")
            showAlert(title: "Offer Text Field Empty", message: "Please Enter the Offer Name")
            
            return
        }
        
        offerName = offerNTF.text!
        productName  = productNTF.text!
        
        datePicker.datePickerMode = .date
        let pickedDate = datePicker.date
        pickedDateG = pickedDate
        
        dateTodays = Date()
        
        print("pickedDate")
        print(pickedDate)
        print("dateTodays")
        print(dateTodays)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        let result = pickedDate.compare(dateTodays)
        print("Compare result of dates \(result)")
        
        print("pickedDate")
        print(pickedDate)
        print("dateTodays")
        print(dateTodays)
        print("selectedDate")
        print(selectedDate)
 
        
        if pickedDate == dateTodays {
            print("Same Date")
            
        }
        
        else if pickedDate < dateTodays {
            print("Expired offer Date")
            print("Minus dates")
            
        }
        else if pickedDate > dateTodays {
            print("Offer Future Date")
            
        }
        
        addData()
        self.dismiss(animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func addData() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let offerObj = Offer(context: managedContext)
        offerObj.offerName = offerName
        offerObj.offerDate = pickedDateG
        offerObj.productName = productName
        offerObj.offerPhoto = UIImagePNGRepresentation(imageSelected) as NSData?
        
        appDelegate.saveContext()
        print("saved context Coredata")
   
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


    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
