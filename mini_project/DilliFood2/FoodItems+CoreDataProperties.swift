//
//  FoodItems+CoreDataProperties.swift
//  DilliFood2
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension FoodItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItems> {
        return NSFetchRequest<FoodItems>(entityName: "FoodItems");
    }

    @NSManaged public var itemPrice: Double
    @NSManaged public var mfgDate: Date?
    @NSManaged public var itemName: String?
    @NSManaged public var itemID: Int64
    @NSManaged public var isVeg: Bool

}
