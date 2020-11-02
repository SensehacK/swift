//
//  CartAddViewController.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
var cartArray : [Double] = []

class CartAddViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedImage = UIImage(named: "question.jpg")
    
    var foodSegue : FoodItems?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var price: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var id: UILabel!
    
    @IBOutlet var qtyL: UILabel!
    
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var totalPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        
        name.text = foodSegue?.itemName
        if let idStr = foodSegue?.itemID {
            id.text = "ID :\(String(idStr))"
        }
        if let priceStr = foodSegue?.itemPrice {
            price.text = "Price :\(String(priceStr))"
        }
    }

    
    @IBAction func imaged(_ sender: Any) {
        
        
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
        
        let imageData = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = imageData
        selectedImage = imageData
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func stepperPressed(_ sender: Any) {
        qtyL.text = String(stepper.value)
        
        if let priceStr = foodSegue?.itemPrice {
            let priceTotal = stepper.value * priceStr
            totalPrice.text = "Total Price : \(String(priceTotal))"
        }
        
    }
    
    
    
    @IBAction func addCart(_ sender: Any) {
        
        saveToCartCoreData()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func saveToCartCoreData() {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let cartObj  = Cart(context: managedContext)
        
        if let priceStr = foodSegue?.itemPrice {
            let priceTotal = stepper.value * priceStr
            cartArray.append(priceTotal)

        }
        
        
        cartObj.imageName = UIImagePNGRepresentation(selectedImage!) as NSData?
        cartObj.itemName = foodSegue?.itemName
        cartObj.quantity = Int64(stepper.value)
        cartObj.itemID = Int64((foodSegue?.itemID)!)
        
        print("Saved the data")
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
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

}
