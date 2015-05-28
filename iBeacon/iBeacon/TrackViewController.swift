//
//  TrackViewController.swift
//  iBeacon
//
//  Created by Annette Undheim on 27/05/15.
//  Copyright (c) 2015 Annette Undheim. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class TrackViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var beaconFoundLabel: UILabel!
    @IBOutlet weak var proximityUuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    // define beacon region
    let locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "97C0BFBB-9977-4869-A13B-4F95EB17EB59"), identifier: "undheim.region")
    
    // globally declare CLBeacon
    var beacon:CLBeacon!
    
    /*
    viewDidLoad
    */
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Set CLLocationManager delegate to self
        locationManager.delegate = self;
        
        // Request authorization
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        //[self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
        
        // Start monitoring
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startUpdatingLocation()
        
        self.beaconFoundLabel.text = "Searching.."
    }
    
    /*
    didStartMonitoringForRegion
    */
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        self.locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    /*
    didEnterRegion
    */
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("Beacon Found");
        self.locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    /*
    didExitRegion
    */
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("Left Region");
        self.locationManager.stopRangingBeaconsInRegion(beaconRegion)
        self.beaconFoundLabel.text = "No";
    }
    
    /*
    didRangeBeacons
    */
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        beacon = CLBeacon()
        beacon = beacons.last as! CLBeacon
        
        self.beaconFoundLabel.text = "Yes";
        self.proximityUuidLabel.text = beacon.proximityUUID.UUIDString;
        self.majorLabel.text = beacon.major.description
        self.minorLabel.text = beacon.minor.description
        self.accuracyLabel.text = beacon.accuracy.description
        if (beacon.proximity == CLProximity.Unknown) {
            self.distanceLabel.text = "Unknown Proximity";
        } else if (beacon.proximity == CLProximity.Immediate) {
            self.distanceLabel.text = "Immediate";
        } else if (beacon.proximity == CLProximity.Near) {
            self.distanceLabel.text = "Near";
        } else if (beacon.proximity == CLProximity.Far) {
            self.distanceLabel.text = "Far";
        }
        self.rssiLabel.text = beacon.rssi.description
    }
    
}