//
//  SurfClient.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/9/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import WebKit
import UIKit


class SurfClient: NSObject {
    
    var studentURL: String?  = "www.udacity.com"
    
    var requestPage: URLRequest?
    
    
    func setRequest()
    {
        if studentURL != nil
        {
        requestPage = URLRequest(url:URL(string: studentURL!)!)
        }
        
        else
        {
            return
        }
    }
    
    
    
    class func sharedInstance() -> SurfClient {
        
        struct Singleton {
            static var sharedInstance = SurfClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
}
