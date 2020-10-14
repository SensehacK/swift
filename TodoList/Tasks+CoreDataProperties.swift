//
//  Tasks+CoreDataProperties.swift
//  TodoList
//
//  Created by Kautilya on 05/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks");
    }

    @NSManaged public var isImportant: Bool
    @NSManaged public var name: String?

}
