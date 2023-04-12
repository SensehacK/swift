//
//  Cart+CoreDataProperties.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart");
    }

    @NSManaged public var itemID: Int64
    @NSManaged public var itemName: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var imageName: NSData?

}
