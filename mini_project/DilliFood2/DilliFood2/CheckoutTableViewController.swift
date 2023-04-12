//
//  CheckoutTableViewController.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var checkoutCDArray : [Cart] = []
    
    
    
    
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


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkoutCDArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)

        
        let cartObj = checkoutCDArray[indexPath.row]
        
        let imageData = UIImage(data: cartObj.imageName as! Data)
        
        cell.textLabel?.text = cartObj.itemName!
        cell.detailTextLabel?.text = String(cartObj.itemID)
        cell.imageView?.image = imageData
        
        return cell
    }
    

    
    @IBAction func checkOutPressed(_ sender: Any) {
        
        var totalPrice : Double = 0
        
        for prices in cartArray {
            print(prices)
            totalPrice += prices
            print(totalPrice)
        }
        
        let str = "Your Total Bill is \(totalPrice)"
        print(str)
        showAlert(title: str, message: "Your Cart has been processed. Thank You for shopping with us. Have A Great Day.")
        
        cartArray.removeAll()
        
        removeCartCoreData()
    }
    
    
    func getCoreData() {
        
        do {
            checkoutCDArray = try appDelegate.persistentContainer.viewContext.fetch(Cart.fetchRequest())
        }
        catch {
            print("error thrown")
        }
    }
    
    
    func removeCartCoreData() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        for index in checkoutCDArray {
            managedContext.delete(index)
            print("Deleting context from Core Data 1 by 1")
        }
        
        appDelegate.saveContext()
        
        print("Deleted the cart")
        
        getCoreData()
        
        tableView.reloadData()
        
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
