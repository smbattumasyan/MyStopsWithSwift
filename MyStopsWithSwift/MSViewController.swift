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
        self.dataController.placeManager.addPlace(["pinTitle": "pinanun", "latitude":(43.200), "longitude": (43.200)])
//        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions


    @IBAction func addButtonAction(sender: AnyObject) {
        self.performSegueWithIdentifier("MSViewController", sender: self)
    }


    // MARK: - Private Methods

    func setupTableView() {
        self.tableView.dataSource     = self.dataController
        self.dataController.tableView = self.tableView
        self.dataController.initFetchedResultsController()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}




