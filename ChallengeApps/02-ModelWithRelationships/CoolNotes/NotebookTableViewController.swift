//
//  NotebookTableViewController.swift
//  CoolNotes
//
//  Created by Sensehack on 05/12/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NotebookTableViewController : CoreDataTableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title
        title = "CoolNotes"
        
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),
                              NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }

    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //find the notebook 
        
        let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
        
        
        //Create the cell
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "NotebookCell", for: indexPath)
        
        //sync the cell
        cell.textLabel?.text = nb.name
        cell.detailTextLabel?.text = "(\(nb.notes?.count) notes "
        
        
        return cell
    }
    
    
    @IBAction func addNewNotebook(_ sender: AnyObject) {
        //Create a NoteBook
        
        let nb = Notebook(name: "A New Note", context: fetchedResultsController!.managedObjectContext)
        
        print("New Note Created  \(nb)")
        

        
    }
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "displayNote" {
            
            if let notesVC = segue.destination as? NotesTableViewController {
                
                // Create Fetch Request
                let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                
                fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),NSSortDescriptor(key: "text", ascending: true)]
                
                // So far we have a search that will match ALL notes. However, we're
                // only interested in those within the current notebook:
                // NSPredicate to the rescue!
                
                let indexPath = tableView.indexPathForSelectedRow!
                let notebook = fetchedResultsController?.object(at: indexPath)
                
                let pred = NSPredicate(format: "notebook = %@", argumentArray: [notebook!])
                
                fr.predicate = pred
                
                // Create FetchedResultsController
                let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext:fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                // Inject it into the notesVC
                notesVC.fetchedResultsController = fc
            }
        }
    }
    
    
}


