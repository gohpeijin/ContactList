//
//  Contact+CoreDataProperties.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var phoneNumber: String?

}
