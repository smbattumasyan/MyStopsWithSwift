//
//  PlaceManager.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 3/31/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class PlaceManager: NSObject {

    let coreDataManager = CoreDataManager()
//    var _fetchedResultsController: NSFetchedResultsController? = nil


    func addPlace(place:NSDictionary) {

        let placeEntity       = NSEntityDescription.entityForName("Place", inManagedObjectContext: self.fetchedResultsController.managedObjectContext)
        print("entity:\(placeEntity)")
        let placeRecord       = Place(entity: placeEntity!, insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext)

        placeRecord.pinTitle  = place.valueForKey("pinTitle") as? String
        placeRecord.latitude  = place.valueForKey("latitude") as? NSNumber
        placeRecord.longitude = place.valueForKey("longitude") as? NSNumber
        print("placeRecord:\(placeRecord)")
        self.coreDataManager.saveContext()
    }


    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }

        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Place", inManagedObjectContext: self.coreDataManager.managedObjectContext)
        fetchRequest.entity = entity

        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20

        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "pinTitle", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController

        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }

        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil

}


