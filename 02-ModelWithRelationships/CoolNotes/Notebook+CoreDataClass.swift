//
//  Notebook+CoreDataClass.swift
//  CoolNotes
//
//  Created by Sensehack on 24/11/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import Foundation
import CoreData

@objc(Notebook)
public class Notebook: NSManagedObject {
   
    convenience init(name : String, context : NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Notebook", in: context) {
            // self.init(entity : ent , insertIntoManagedObjectContext : context)
            self.init(entity: ent,
                      insertInto: context)
            self.name = name
            self.creationDate = Date()
            
        }
        else {
            fatalError("Unable to find Entity Name!")
        }
        
        
    }
    
    

}
