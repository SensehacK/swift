//
//  OfferTableViewController.swift
//  OfferZone
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class OfferTableViewController: UITableViewController {

    
    
    @IBOutlet var tableView2: UITableView!
    var offerCoreArray : [Offer] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedOfferObj : Offer?
    var currentOffer  : [Offer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view did load")
        getCoreData()
        
        let dateTodays = Date()
        for index in offerCoreArray {
            
            let pickedDate = index.offerDate
            if pickedDate! > dateTodays {
                currentOffer.append(index)
            }
        }
        
        print("//////////////////////////////////")
        print("//////////////////////////////////")
        print(currentOffer.count)

        tableView2.reloadData()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("in view did appear")
        getCoreData()
        tableView2.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentOffer.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offersTableCell", for: indexPath)
        
        let offerObject = currentOffer[indexPath.row]
        let imagedata  = UIImage(data:offerObject.offerPhoto as! Data)

        cell.imageView?.image = imagedata
        cell.textLabel?.text = offerObject.productName
        cell.detailTextLabel?.text = offerObject.offerName

        return cell
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let offerObj  = currentOffer[indexPath.row]
        selectedOfferObj = offerObj
        performSegue(withIdentifier: "showCurrentOfferSegue", sender: offerObj)
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            print("Delete Table Row")
            
            let selectedOffer = currentOffer[indexPath.row]
            
            appDelegate.persistentContainer.viewContext.delete(selectedOffer)
            
            appDelegate.saveContext()
            getCoreData()
            tableView2.reloadData()
        }
    }

    func getCoreData () {
        
        do {
            offerCoreArray = try appDelegate.persistentContainer.viewContext.fetch(Offer.fetchRequest())
            print("Core Data Fetched in Offer Table View")
        }
        catch {
            print("Error in fetching core data")
        }
       
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In prepare segue function")
        
        if segue.identifier == "showCurrentOfferSegue" {
            print("In showCurrentOfferSegue ")
            
            
            let displayVC = segue.destination as! DisplayViewController
            
            displayVC.displayObject = selectedOfferObj
            
        }
    }
    

}
