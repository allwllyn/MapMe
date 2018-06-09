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



class MapViewController: UIViewController, MKMapViewDelegate, UITabBarControllerDelegate, UITableViewDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    let uniqueKey = UdacityClient.sharedInstance().uniqueKey
    
    var studentArray = MapInteract.sharedInstance().studentLocationArray
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        dropPins(mapView)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
       dropPins(mapView)
        
    }
    
    
    @IBAction func postPin(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "InputLocationController")
        
        controller!.modalPresentationStyle = .fullScreen
        
       self.navigationController?.pushViewController(controller!, animated: true)
        
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
    
    func showAlert()
    {
        let alertController = UIAlertController(title: "Alert", message:
            "You're already mapped!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
   
}
