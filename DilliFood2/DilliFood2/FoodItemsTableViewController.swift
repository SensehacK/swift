//
//  FoodItemsTableViewController.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class FoodItemsTableViewController: UITableViewController {

    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var foodItemsCDArray : [FoodItems] = []
    var foodObjSegue : FoodItems?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCoreData()
        
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCoreData()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodItemsCDArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemsCell", for: indexPath)
        
        let foodItemObj = foodItemsCDArray[indexPath.row]
        let foodType = foodItemObj.isVeg ? "Veg" : "Non-Veg"
        
        cell.textLabel?.text = foodItemObj.itemName!
        cell.detailTextLabel?.text = foodType
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let FoodObj = foodItemsCDArray[indexPath.row]
        
        foodObjSegue = FoodObj
        performSegue(withIdentifier: "cartAddSegue", sender: nil)
    }
    
    func getCoreData() {
        
        do {
            foodItemsCDArray = try appDelegate.persistentContainer.viewContext.fetch(FoodItems.fetchRequest())
        }
        catch {
            print("error thrown")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cartAddSegue" {
            let vc = segue.destination as! CartAddViewController
            vc.foodSegue = foodObjSegue
        }
        
        
    
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
*/
    
    
}
