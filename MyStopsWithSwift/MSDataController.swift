//
//  MSDataController.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 4/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class MSDataController: NSObject, UITableViewDataSource,  NSFetchedResultsControllerDelegate{
    let placeManager = PlaceManager()
    var tableView : UITableView!

    // MARK: - Table View Data Source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let sectionInfo = self.placeManager.fetchedResultsController!.sections![section]
        return (self.placeManager.fetchedResultsController.fetchedObjects?.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! MSTableViewCell
        let place = (self.placeManager.fetchedResultsController.objectAtIndexPath(indexPath)) as! Place

        cell.place = place
        return cell
    }

    // MARK: - Fetched results controller

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update: break
        //            self.configureCell(self.tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! NSManagedObject)
        case .Move:
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    func initFetchedResultsController() {
        self.placeManager.fetchedResultsController.delegate = self
    }
}




