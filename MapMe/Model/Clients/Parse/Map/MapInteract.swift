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

class MapInteract: NSObject
{
    
    
    var pinLocations = [MKPointAnnotation]()
    

    func locationsToMKAnnotation(_ map: MKMapView)
    {
        //pinLocations?.append(ParseClient.sharedInstance().studentLocations as! MKAnnotation)
        
        ParseClient.sharedInstance().getLocations()
            {
                (success) in
                    
                    if success
                    {
                        
                        var locationArray = ParseClient.sharedInstance().studentLocations!
                        print(locationArray.count)
                                for dictionary in locationArray[0...2]
                                    {
                                        print("- - - - - - -\n- - - - - - - ")
                                        print(dictionary)
                                        
                                        if dictionary["latitude"] == nil {
                                            return
                                        }
                                        
                                        let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
                                        let long = CLLocationDegrees(dictionary["longitude"] as! Double)
            
                                        let coordinate = CLLocationCoordinate2DMake(lat, long)
                                        
                                        let title = dictionary["firstName"]
                                        
                                        let subTitle = dictionary["mediaURL"]
            
                                        let annotation = MKPointAnnotation()
                                        annotation.coordinate = coordinate
                                        annotation.title = title as? String
                                        annotation.subtitle = subTitle as? String
            
                                        self.pinLocations.append(annotation)
                                        print("- - - - - \n- - - - - \n- - - - - \n- - - - -")
                                        print(self.pinLocations)
                                        print("- - - - -\n- - - - - \n- - - - -")
                                    }
                        map.addAnnotations(self.pinLocations)
                    }
            }
    }
    
    class func sharedInstance() -> MapInteract {
    
    struct Singleton {
    static var sharedInstance = MapInteract()
    }
    return Singleton.sharedInstance
    
    }
    
    
    
}
