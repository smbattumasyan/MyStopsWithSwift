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
        let placeRecord       = Place(entity: placeEntity!, insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext)

        placeRecord.pinTitle  = place.valueForKey("pinTitle") as? String
        placeRecord.latitude  = place.valueForKey("latitude") as? NSNumber
        placeRecord.longitude = place.valueForKey("longitude") as? NSNumber
        self.coreDataManager.saveContext()
    }

    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Place")

        fetchRequest.fetchBatchSize = 20
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "pinTitle", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try fetchedResultsController.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }

        // Configure Fetched Results Controller
//        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()

}


