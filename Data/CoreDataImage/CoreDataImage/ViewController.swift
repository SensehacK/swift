//
//  ViewController.swift
//  CoreDataImage
//
//  Created by Kautilya on 07/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var secondImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In view Did Load")
        // ENcoding
        let image  = UIImage(named: "xbox.png")
        
        // Convert into NSData
        let imageData : NSData = UIImagePNGRepresentation(image!)! as NSData
        
        //Prints the image data
//        print(imageData)
        
        
        // Save it in UserDefaults
        
        
        UserDefaults.standard.set(imageData , forKey: "savedImage")
        
        // Get the image back.
        // Decode 
        
        let decodeImage = UserDefaults.standard.object(forKey: "savedImage")
        
        // Replace the image
        
        imageView.image = UIImage(data: decodeImage as! Data)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("In view will appear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    @IBAction func galleryButton(_ sender: Any) {
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
        print("Picked Image function")
        let imagePicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = imagePicked
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Did Cancel Func")
        picker.dismiss(animated: true, completion: nil)
    }
    

    func showAlert(title : String , message: String) {
        print("In the show Alert")
        let alertDisplay = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let pressOK = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertDisplay.addAction(pressOK)
        present(alertDisplay, animated: true, completion: nil)
    }
    
}

