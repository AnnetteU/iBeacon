//
//  ViewController.swift
//  iBeacon
//
//  Created by Annette Undheim on 27/05/15.
//  Copyright (c) 2015 Annette Undheim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTrackViewController(sender: UIButton) {
        
        // Get the TrackViewController
        var controller: TrackViewController
        
        // get controller
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("TrackViewController") as! TrackViewController
        
        // Present the view Controller
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showTransmitViewController(sender: UIButton) {
        
        // Get the TransmitViewController
        var controller: TransmitViewController
        
        // get controller
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("TransmitViewController") as! TransmitViewController
        
        // Present the view Controller
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}

