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
import WebKit



class MapViewController: UIViewController, MKMapViewDelegate, UITabBarControllerDelegate, UITableViewDelegate, UIWebViewDelegate
{
    

    @IBOutlet weak var mapView: MKMapView!
    
    
    let uniqueKey = UdacityClient.sharedInstance().uniqueKey
    
    var studentArray = MapInteract.sharedInstance().studentLocationArray
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
      
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        mapView.delegate = self
      //formatAlert()
        dropPins(mapView)
    }
    
    func mapView(_ mapView: MKMapView, viewFor view: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil
        {
            pinView = MKPinAnnotationView(annotation: view, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
            
        else
        {
            pinView!.annotation = view
        }
        
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if control == view.rightCalloutAccessoryView
        {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle!
            {
                app.open(NSURL(string: toOpen)! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    @IBAction func postPin(_ sender: Any)
    {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "InputLocationController")
        
        controller!.modalPresentationStyle = .fullScreen
        
       self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
    @IBAction func refresh(_ sender: Any)
    {
        mapView.removeAnnotations(mapView.annotations)
        performUIUpdatesOnMain {
          self.dropPins(self.mapView)
        }
                
    }
    
    let alert = UIAlertController(title: "Alert Test", message: "Have you been alerted?", preferredStyle: .alert)
    
    
    func formatAlert()
    {
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
    
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
    self.present(alert, animated: true)
    }
    
    func dropPins(_ map: MKMapView)
    {
        MapInteract.sharedInstance().mapPins(map)
    }
    
   
    

    
   
}
