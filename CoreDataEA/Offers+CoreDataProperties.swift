//
//  Offers+CoreDataProperties.swift
//  CoreDataEA
//
//  Created by Kautilya on 08/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension Offers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Offers> {
        return NSFetchRequest<Offers>(entityName: "Offers");
    }

    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Float

}
