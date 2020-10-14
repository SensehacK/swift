//
//  ViewController.swift
//  TodoList
//
//  Created by Kautilya on 05/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet var tableView: UITableView!
    
    var tasksList : [Tasks] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // I can't use direct object in starting only
    
//    let managedContext = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setting the Delegates
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetching core data objects ., calling function
        print("In View will Appear")
        getCoreData()
        
        // table reload
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        let task = tasksList[indexPath.row]
//        print(indexPath.row)
//        print("IndexPath count : \(indexPath.count) ")
        if task.isImportant {
            cell.textLabel?.text = " 😱 \(task.name!)"
        }
        else
        {
        cell.textLabel?.text = task.name
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasksList[indexPath.row]
        print("Index path prints : \(indexPath.row)" )
        
        print(task.name!)
        
        print("Selected Row's Name is : \(task.name!)")
        performSegue(withIdentifier: "TableDataSelectedSegue", sender: task.name)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        print("In commit function of table view")
        if editingStyle == .delete {
            print("Deleting Values")
            
            let selectedTask = tasksList[indexPath.row]
            
            appDelegate.persistentContainer.viewContext.delete(selectedTask)
            
            appDelegate.saveContext()
            
            
            //Code reusability from function defined earlier
            getCoreData()
            
            //Reload Table View
            tableView.reloadData()
            print("reloaded Table")
            
        }
        
        
    }
    
    
    
    
    // Extra function for fetching the Core data entity objects
    func getCoreData() {
        print("fetching core data Table")
        do {
            tasksList =  try appDelegate.persistentContainer.viewContext.fetch(Tasks.fetchRequest())
        }
        catch {
            print("Core data fetching error")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TableDataSelectedSegue" {
            
        
        let segueTableObject = segue.destination as! TableNewViewController
        
        segueTableObject.passedData = sender as! String
        }
    }
    
    
}


