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



class MapViewController: UIViewController, MKMapViewDelegate, UITabBarControllerDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
       dropPins(mapView)
        
        
        
    }
    
    
    @IBAction func postPin(_ sender: Any) {
        
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PostPinController")
        
        controller!.modalPresentationStyle = .fullScreen
        
       self.present(controller!, animated: true, completion: nil)
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        performUIUpdatesOnMain {
          self.dropPins(self.mapView)
        }
        
        
    }
    
    
    func dropPins(_ map: MKMapView){
        
        MapInteract.sharedInstance().mapPins(map)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(NSURL(string: toOpen)! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
