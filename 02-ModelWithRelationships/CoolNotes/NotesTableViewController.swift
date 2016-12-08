
//
//  NotesTableViewController.swift
//  CoolNotes
//
//  Created by Sensehack on 07/12/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NotesTableViewController : CoreDataTableViewController {
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the note
        let note = fetchedResultsController?.object(at: indexPath) as! Note
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        // Sync note -> cell
        cell.textLabel?.text = note.text
        
        // Return the cell
        return cell
    }
    
    @IBAction func addNewNote(_ sender: AnyObject) {
        //Create a Note 
        
        let nb = Note(text: "A New Note", context: fetchedResultsController!.managedObjectContext)
        
        print("New Note Created \(nb)")
    
    
    }
    
    
    
    
}


