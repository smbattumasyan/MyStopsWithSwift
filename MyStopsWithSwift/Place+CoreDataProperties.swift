//
//  Place+CoreDataProperties.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 3/31/16.
//  Copyright © 2016 EGS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var pinTitle: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?

}
