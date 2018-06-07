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

class MapInteract: NSObject
{
    let LocationManager = CLLocationManager()
    
    let geoCoder = CLGeocoder()
    
    var userInputLocation = MKPointAnnotation()
    
    var userPlacemark = CLPlacemark()
    
    var pinPreview = MKPointAnnotation()
    
    var pinLocations = [MKPointAnnotation]()
    
    var studentLocationArray = [StudentLocation]()
    
    var userAddressString: String?
    

    func resultToStudent(_ completion: @escaping (_ success: Bool) -> Void)
    {
        
        ParseClient.sharedInstance().getLocations()
            {
                (success) in
                    
                    if success
                    {
                        
                        var locationArray = ParseClient.sharedInstance().studentLocations!
                        print(locationArray.count)
                                for dictionary in locationArray
                                    {
                                        
                                        if dictionary["latitude"] == nil
                                        {
                                            return
                                        }
                                        else if dictionary["uniqueKey"] == nil
                                        {
                                            return
                                        }
                                        
                                    let newLocation = StudentLocation(dictionary)
                                        
                                    self.studentLocationArray.append(newLocation)
                                        
                                        }
                        completion(true)
                    }
            }
    }
    
    func dataToPins(_ completion: @escaping (_ success: Bool) -> Void)
    {
        
        for student in studentLocationArray
        {
            let pin = MKPointAnnotation()
            var lat: Double = 0.0
            var lon: Double = 0.0
            if student.latitude != nil
            {
                lat = CLLocationDegrees(student.latitude!)
            }
            if student.longitude != nil
            {
                lon = CLLocationDegrees(student.longitude!)
            }
            let pinPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            pin.coordinate = pinPoint
            pin.title = "\(student.firstName) \(student.lastName)"
            pin.subtitle = student.mediaURL
            
            print(pin.title)
            
            self.pinLocations.append(pin)
            
        }
        
        completion(true)
        
    }
    
    func mapPins(_ map: MKMapView)
    {
        resultToStudent()
            { (success) in
        
                self.dataToPins()
                    { (success) in
                        if success
                        {
                            map.addAnnotations(self.pinLocations)
                        }
                    }
            }
    }
    
    func cityNameToLatLon(_ cityName: String, _ map: MKMapView){
        
        geoCoder.geocodeAddressString(cityName)
        {
            (placemarks, error) in
            let placemark = placemarks
            let location = placemark?.first?.location
            let locaLocation = location?.coordinate
            
            self.pinPreview.coordinate = locaLocation!
        }
        
        map.addAnnotation(pinPreview)
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
