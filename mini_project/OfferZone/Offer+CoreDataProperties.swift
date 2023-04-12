//
//  Offer+CoreDataProperties.swift
//  OfferZone
//
//  Created by Kautilya on 12/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation
import CoreData


extension Offer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Offer> {
        return NSFetchRequest<Offer>(entityName: "Offer");
    }

    @NSManaged public var offerName: String?
    @NSManaged public var offerDate: Date?
    @NSManaged public var offerPhoto: NSData?
    @NSManaged public var productName: String?

}
