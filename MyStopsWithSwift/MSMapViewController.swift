//
//  MSMapViewController.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 4/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MSMapViewController: UIViewController, CLLocationManagerDelegate {

    var manager : CLLocationManager!


    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLocationManager()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Location Manager

    func setupLocationManager() {
        self.manager = CLLocationManager()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestAlwaysAuthorization()
        self.manager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let newLocation = locationArray.lastObject as! CLLocation
        let locationCoordinate = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        self.setRegion(locationCoordinate)
    }

    // MARK: - Private Methods

    func setRegion(locationCoordinate:CLLocationCoordinate2D)  {
        let region = MKCoordinateRegionMake(locationCoordinate, MKCoordinateSpanMake(0.05, 0.05))
        self.mapView.setRegion(region, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
