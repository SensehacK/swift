//
//  Customer2+CoreDataProperties.swift
//  CoreDataPhoto
//
//  Created by Kautilya on 11/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension Customer2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer2> {
        return NSFetchRequest<Customer2>(entityName: "Customer2");
    }

    @NSManaged public var photoImage: NSData?

}
