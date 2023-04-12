//
//  ViewController.swift
//  CoreDataPhoto
//
//  Created by Kautilya on 11/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit



class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var galleryButton: UIButton!
    
    var imageSelected : UIImage! //= UIImage(named: "images.jpg")!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var imaKautilyaoreData : [Customer2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getCoreData()
        
//        let managedContext = appDelegate.persistentContainer.viewContext
        

//        for index in imaKautilyaoreData {
//            print("In index")
//            print(index)
//           imageView.image =  UIImage(data:index.photoImage as! Data)
//        }
        
        for index in imaKautilyaoreData {
            print(index)
//            let imageDa = index.photoImage! as NSData
//            let image  = UIImage(data:imageDa as Data)
            let image  = UIImage(data:index.photoImage as! Data)
            imageView.image = image
//
            
//            if let imageData = index.value(forKey: "photoImage") as? NSData {
//                    if let image = UIImage(data:imageData as Data) {
//                        imageView.image = image
//                    }
//            }
        
        }
        
        
        
//        let imageData = UIImage(data: customerObject.photoImage as! Data)
//        
//
//        
//        imageView.image = imageData
        
        
    }

    
    @IBAction func galleryButtonPressed(_ sender: Any) {
    
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
        print("Selected the image")

        let imagePicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = imagePicked
        imageSelected = imagePicked
        trialFunction()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel Image picker View")
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func trialFunction() {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        let customerObject = Customer2(context: managedContext)
        
        
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer2")
//        let request = NSBatchDeleteRequest(fetchRequest: fetch)
//        
//        let result = try managedObjectContext.executeRequest(request)
//        
        
        
        //Delete older Context methods
        for index in imaKautilyaoreData {
            managedContext.delete(index)
        }
        print("Deleted items context")
        
        
        customerObject.photoImage = UIImagePNGRepresentation(imageSelected) as NSData?
     
        appDelegate.saveContext()
        print("/////////////////////////////")
        print("Image saved")
    }
    
    
    
    func getCoreData() {
        
        for index in imaKautilyaoreData {
            print(imaKautilyaoreData)
        }
        
        
        do {
            imaKautilyaoreData = try appDelegate.persistentContainer.viewContext.fetch(Customer2.fetchRequest())
            print("CoreData Fetched")
            
        }
        catch {
            
            print("Hello")
        }

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


    
}
