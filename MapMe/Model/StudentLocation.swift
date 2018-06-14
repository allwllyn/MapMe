//
//  StudentLocation.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/19/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import MapKit


struct StudentLocation
{
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
    
    
    init (_ dictionary: [String:AnyObject]){
        
        createdAt = dictionary[ParseClient.Constants.JSONResponseKeys.createdAt] as? String
        firstName = dictionary[ParseClient.Constants.JSONResponseKeys.firstName] as? String
        lastName = dictionary[ParseClient.Constants.JSONResponseKeys.lastName] as? String
        latitude = dictionary[ParseClient.Constants.JSONResponseKeys.latitude] as? Double
        longitude = dictionary[ParseClient.Constants.JSONResponseKeys.longitude] as? Double
        mapString = dictionary[ParseClient.Constants.JSONResponseKeys.mapString] as? String
        mediaURL = dictionary[ParseClient.Constants.JSONResponseKeys.mediaURL] as? String
        objectId = dictionary[ParseClient.Constants.JSONResponseKeys.objectId] as? String
        uniqueKey = dictionary[ParseClient.Constants.JSONResponseKeys.uniqueKey] as? String
        updatedAt = dictionary[ParseClient.Constants.JSONResponseKeys.updatedAt] as? String
    }
    

}


