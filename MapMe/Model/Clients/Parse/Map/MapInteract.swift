//
//  MapInteract.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/26/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

class MapInteract: NSObject, MKMapViewDelegate
{
    let LocationManager = CLLocationManager()
    
    let geoCoder = CLGeocoder()
    
    var userInputLocation = MKPointAnnotation()
    
    var userPlacemark = CLPlacemark()
    
    var pinPreview = MKPointAnnotation()
    
    var pinLocations = [MKPointAnnotation]()
    
  
    
    var studentLocationArray = [StudentInformation]()
    
    var userAddressString: String?
    
    var activitySpin = UIActivityIndicatorView()
    
     let alert = UIAlertController(title: "Error", message: "That didn't quite work. Go back and try something a little different.", preferredStyle: .alert)
    
    

    func resultToStudent(_ completion: @escaping (_ success: Bool) -> Void)
    {
        studentLocationArray = []
        
        ParseClient.sharedInstance().getLocations()
            {
                (success) in
                    
                    if success
                    {
                        
                        var locationArray = ParseClient.sharedInstance().studentLocations!
                        print(locationArray.count)
                                for dictionary in locationArray
                                    {                                
                                      if dictionary["latitude"] != nil
                                        {
                                            let newLocation = StudentInformation(dictionary)
                                            
                                            self.studentLocationArray.append(newLocation)
                                        }
                                    }
                        print("completion true")
                        completion(true)
                    }
            }
    }
    
    func dataToPins(_ completion: @escaping (_ success: Bool) -> Void)
    {
        print("starting but not working")
        
        for student in studentLocationArray
        {
            let pin = MKPointAnnotation()
            var lat: Double = 0.0
            var lon: Double = 0.0
            
            if student.latitude != nil
            {
                lat = CLLocationDegrees(student.latitude!)
                lon = CLLocationDegrees(student.longitude!)
            }
            else
            {
                continue
            }
            
            let pinPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            pin.coordinate = pinPoint
            pin.title = "\(student.firstName!) \(student.lastName!)"
            pin.subtitle = student.mediaURL
            
        
            print(pin.title!)
            
            self.pinLocations.append(pin)
        }
        
        completion(true)
        
    }
    
    func mapPins(_ map: MKMapView)
    {
        resultToStudent()
            { (success) in
                if success
                {
                    self.dataToPins()
                    { (success) in
                        if success
                        {
                            map.addAnnotations(self.pinLocations)
                        }
                        
                    }
                }
            }
    }
    
    func cityNameToLatLon(_ cityName: String, _ map: MKMapView, _ view: UIViewController, _ nav: UINavigationController){
        
        
        geoCoder.geocodeAddressString(cityName)
        {
    
            (placemarks, error) in
            let placemark = placemarks
            if placemark != nil
                {
                    let location = placemark?.first?.location
                
                    let locaLocation = location?.coordinate
                
                    self.pinPreview.coordinate = locaLocation!
                    
                     map.setRegion(MKCoordinateRegion(center: self.pinPreview.coordinate, span: MKCoordinateSpan(latitudeDelta: 15.0, longitudeDelta: 15.0)), animated: true)
                }
            else
            {
              self.formatAlert(view, nav)
        
            }
        }
        
        map.addAnnotation(pinPreview)
    }
    
    func showActivity(_ view: UIView) {
        activitySpin = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activitySpin.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activitySpin.startAnimating()
        view.addSubview(activitySpin)
    }
    
    func formatAlert(_ view: UIViewController, _ nav: UINavigationController)
    {
        
        let backAction = UIAlertAction(title: "Back", style: .default)
        {
            UIAlertAction in
            nav.popViewController(animated: true)
            self.alert.dismiss(animated: false, completion: nil)
            }
        
        if alert.actions == []
        {
            alert.addAction(backAction)
        }
        view.present(self.alert, animated: true, completion: nil)
    }
    
    func dropPins(_ map: MKMapView)
    {
        MapInteract.sharedInstance().mapPins(map)
    }
    
    class func sharedInstance() -> MapInteract
    {
        struct Singleton
        {
            static var sharedInstance = MapInteract()
        }
    return Singleton.sharedInstance
    
    }


    
}
