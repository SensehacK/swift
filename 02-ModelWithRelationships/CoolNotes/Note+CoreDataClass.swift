//
//  Note+CoreDataClass.swift
//  CoolNotes
//
//  Created by Sensehack on 24/11/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    convenience init(text : String = "New Note" , context : NSManagedObjectContext) {
    
        if let ent = NSEntityDescription.entity(forEntityName: "Note", in: context) {
            // self.init(entity : ent , insertIntoManagedObjectContext : context)
            self.init(entity: ent,
            insertInto: context)
            self.text  = text
            self.creationDate = Date()
            
            
            
        } else {
            fatalError("Unable to find Entity Name!")
        }
        
        
    }
    
    var humanReadableAge : String {
        get {
            let fmt = DateFormatter()
            
            fmt.timeStyle = .none
            fmt.dateStyle = .short
            fmt.doesRelativeDateFormatting = true
            fmt.locale  = Locale.current
            
            return fmt.string(from: creationDate! as Date)
        }
    }
    
    
    
}
