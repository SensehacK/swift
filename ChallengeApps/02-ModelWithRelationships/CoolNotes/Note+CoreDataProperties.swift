//
//  Note+CoreDataProperties.swift
//  CoolNotes
//
//  Created by Sensehack on 24/11/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var text: String?
    @NSManaged public var notebook: Notebook?

}
