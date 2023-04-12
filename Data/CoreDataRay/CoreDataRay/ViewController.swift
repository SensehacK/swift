//
//  ViewController.swift
//  CoreDataRay
//
//  Created by Kautilya on 04/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
//    var names : [String] = []
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List is Mine"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //1 
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Person")
        
        
        //3 
        
        do {
            people = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print("Couldn't fetch data \(error)")
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        // Alert Box
        
        let alert = UIAlertController(title: "New NAme", message: "Add a New Name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            print(alert.textFields?.first as Any)
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            

            
            
        self.save(name : nameToSave)
        self.tableView.reloadData()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert , animated: true)
        
    }
    
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    

}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let person = people[indexPath.row]
            print("????? People List of core data objects ??????")
            print(people[indexPath.row])
            print("indexPath.row")
            print(indexPath.row)
            
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text = person.value(forKeyPath: "name") as? String
            return cell
    }
}
