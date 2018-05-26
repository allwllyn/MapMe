//
//  ParseConstants.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/19/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation

extension ParseClient {
    
    
    
    struct Constants {
        
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        //MARK: URLs
        static let scheme = "https"
        static let apiHost = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        
        //MARK: Parameters
        
        
        struct JSONResponseKeys {
            
            static let createdAt = "createdAt"
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let latitude = "latitude"
            static let longitude = "longitude"
            static let mapString = "mapString"
            static let mediaURL = "mediaURL"
            static let objectId = "objectId"
            static let uniqueKey = "uniqueKey"
            static let updatedAt = "updatedAt"
            }
        
        
        
        
    }
    
    
}
