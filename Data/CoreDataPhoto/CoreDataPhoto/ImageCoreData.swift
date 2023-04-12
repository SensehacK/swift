//
//  ImaKautilyaoreData.swift
//  CoreDataPhoto
//
//  Created by Kautilya on 11/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

/*
import Foundation
import CoreData
import UIKit


class ImaKautilyaoreData  {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var arrayCoreData : [Customer2] = []
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Selected the image")
        let imagePicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = imagePicked
        imageSelected = imagePicked
        storeToCoreData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel Image picker View")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func storeToCoreData() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let customerCoreDataObj = Customer2(context: managedContext)
        customerCoreDataObj.name = nameTextField.text!
        customerCoreDataObj.occupation = occupationTextField.text!
        customerCoreDataObj.age = Int16(ageValueSlider)
        customerCoreDataObj.gender = isGenderSelected
        customerCoreDataObj.indian = isIndian
        
        customerCoreDataObj.photoImage = UIImagePNGRepresentation(imageSelected) as NSData?
        
        appDelegate.saveContext()
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func getCoreData() {
        do {
             arrayCoreData = try appDelegate.persistentContainer.viewContext.fetch(Customer2.fetchRequest())
        }
        catch {
            print("Hello")
        }
    }
    
    func displayCoreData() {
        
        let custObj = customerslist[indexPath.row]
        custObj.name
        for index in arrayCoreData {
            let image  = UIImage(data:index.photoImage as! Data)
            imageView.image = image
        }
    }

    
    
    
    
}
 
 
 
 */
