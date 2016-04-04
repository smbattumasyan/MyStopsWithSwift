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

    let dataController = MSMapDataController()

    var manager : CLLocationManager!
    var aPlace : NSMutableDictionary!

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


    @IBAction func longPressOnMapGestureAction(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.Began {
            return
        }
        let touchLocation = sender.locationInView(self.mapView)
        self.getPinCoordinatesFromMap(touchLocation)
        self.alertNewPin()
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

    func getPinCoordinatesFromMap(touchLocation:CGPoint) {
        let locationCoordinate = self.mapView .convertPoint(touchLocation, toCoordinateFromView: self.mapView)
        self.aPlace = NSMutableDictionary(dictionary: ["latitude":(locationCoordinate.latitude), "longitude": (locationCoordinate.longitude)])
    }

    func addPinOnMap() {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2DMake(self.aPlace.valueForKey("latitude") as! CLLocationDegrees, self.aPlace.valueForKey("longitude") as! CLLocationDegrees)
        annotation.coordinate = locationCoordinate
        self.mapView .addAnnotation(annotation)
    }

    func savePin() {
        self.dataController.placeManager.addPlace(self.aPlace)
    }

    func alertNewPin() {
        let newPinAlert = UIAlertController(title: "New Pin", message: "Do yo want to add new pin here", preferredStyle: UIAlertControllerStyle.Alert)
        newPinAlert.addTextFieldWithConfigurationHandler{(textField:UITextField) -> Void in
            textField.placeholder  = "Pin Name";
            textField.keyboardType = UIKeyboardType.Default;
        }
        let save = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {(alert:UIAlertAction) -> Void in
            let textField = newPinAlert.textFields![0] 
            self.aPlace.addEntriesFromDictionary(["pinTitle": textField.text!])
            print("aplace\(self.aPlace)")
            self.savePin()
            self.addPinOnMap()
        })

        let cancel = UIAlertAction(title:  "Cancel", style: UIAlertActionStyle.Default, handler: {(alert:UIAlertAction) -> Void in

        })

        newPinAlert.addAction(cancel)
        newPinAlert.addAction(save)

        self.presentViewController(newPinAlert, animated: true, completion: nil)
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
