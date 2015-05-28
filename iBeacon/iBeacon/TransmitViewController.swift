//
//  TransmitViewController.swift
//  iBeacon
//
//  Created by Annette Undheim on 27/05/15.
//  Copyright (c) 2015 Annette Undheim. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreBluetooth

class TransmitViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var transmitStatusLabel: UILabel!
    
    // initialise beacon region
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "97C0BFBB-9977-4869-A13B-4F95EB17EB59"), identifier: "undheim.region")
    
    // declare peripheral data as dictionary and peripheralManager
    var beaconPeripheralData = [Int: String]()
    var peripheralManager : CBPeripheralManager?
    
    /*
    viewDidLoad
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    /*
    Update labels
    */
    func setLabels() {
        self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
        self.majorLabel.text = beaconRegion.major.description
        self.minorLabel.text = beaconRegion.minor.description
        self.identityLabel.text = self.beaconRegion.identifier;
    }
    
    /*
    transmitBeacon
    Set beaconPeripheralData
    Create CBPeripheralManager
    Update status text
    */
    @IBAction func transmitBeacon(sender: UIButton) {
        var beaconPeripheralData = beaconRegion.peripheralDataWithMeasuredPower(nil)
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        self.transmitStatusLabel.text = "Transmitting";
    }
    
    /*
    peripheralManagerDidUpdateState
    */
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        
        if (peripheral.state == CBPeripheralManagerState.PoweredOn) {
            println("Powered On")
            peripheralManager?.startAdvertising(self.beaconPeripheralData)
            println("Started advertising")
        } else if (peripheral.state == CBPeripheralManagerState.PoweredOff) {
            println("Powered Off")
            peripheralManager?.stopAdvertising()
        }
    }
}