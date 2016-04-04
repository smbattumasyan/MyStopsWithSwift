//
//  MSViewController.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 3/31/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class MSViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let dataController = MSDataController()

    // MARK: - Life Cyrcle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View Delegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let place = self.dataController.placeManager.fetchedResultsController.objectAtIndexPath(indexPath) as! Place
        self.setupDirectionWithPlace(place)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - IBActions


    @IBAction func addButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("MSViewController", sender: self)
    }


    // MARK: - Private Methods

    func setupDirectionWithPlace(place: Place) {
        let urlString = NSString(format: "http://maps.apple.com/maps?daddr=%f,%f",(place.latitude?.floatValue)!,(place.longitude?.floatValue)!) as String
        print("url: \(urlString)")
        UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
    }

    func setupTableView() {
        self.tableView.dataSource     = self.dataController
        self.dataController.tableView = self.tableView
        self.dataController.initFetchedResultsController()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mapViewController = segue.destinationViewController as! MSMapViewController
        mapViewController.dataController.placeManager = self.dataController.placeManager
    }
}




