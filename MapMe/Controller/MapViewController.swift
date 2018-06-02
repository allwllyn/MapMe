//
//  MapViewController.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/14/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController, MKMapViewDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        loadPins()
        
        
        
    }
    
    
    @IBAction func postPin(_ sender: Any) {
        
        
    }
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    func loadPins()
    
    {
        
        MapInteract.sharedInstance().locationsToMKAnnotation(mapView)
    }
    
    
    
    
}
