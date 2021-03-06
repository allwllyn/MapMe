//
//  Parse.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/19/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ParseClient: NSObject
{

    var studentLocations: [[String:AnyObject]]?
    
     let alert = UIAlertController(title: "Error", message: "Please check you Network Connection.", preferredStyle: .alert)
    
    func getLocations(_ completionHandler: @escaping (_ success: Bool) -> Void)
    {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?order=-updatedAt&limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        {
            data, response, error in
            
            //Check Error
            func sendError(_ error: String)
            {
                print(error)
            }
            
            //GUARD: Was there an error?
            guard (error == nil) else
            {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            //GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("Status code returned other than 2XX, \((response as? HTTPURLResponse)?.statusCode)")
                return
            }
            
            //GUARD: Was there any data returned?
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            // 5-6. Parse the data and use the data
            
            print(String(data: data, encoding: .utf8)!)
            
            var parsedResult: [String:AnyObject]?
            
            do
            {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            }
            catch
            {
                print("could not parse data")
            }
            
            self.studentLocations = parsedResult!["results"] as! [[String:AnyObject]]
            completionHandler(true)
        }
        task.resume()
    }

    
    func postLocation(_ firstName: String?,_ lastName: String?, _ uniqueKey: String?, _ lat: Double?, _ lon: Double?, mapString: String?, mediaURL: String?, _ view: UIViewController, _ nav: UINavigationController)
    {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey!)\", \"firstName\": \"\(firstName!)\", \"lastName\": \"\(lastName!)\",\"mapString\": \"\(mapString!)\", \"mediaURL\": \"\(mediaURL!)\",\"latitude\": \(lat!), \"longitude\": \(lon!)}".data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request)
        {
            data, response, error in
            
            //Check Error
            func sendError(_ error: String)
            {
                print(error)
                self.formatAlert(view, nav)
            }
            
            //GUARD: Was there an error?
            guard (error == nil) else
            {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            //GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("Status code returned other than 2XX, \((response as? HTTPURLResponse)?.statusCode)")
                return
            }
            
            //GUARD: Was there any data returned?
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            // 5-6. Parse the data and use the data
            
            print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()
    }

    

    // MARK: Update existing location : NOT IMPLEMENTED
   /* func updateLocation(_ firstName: String,_ lastName: String, _ uniqueKey: String, _ lat: Double, _ lon: Double, mapString: String, mediaURL: String)
    {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8")!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(lat), \"longitude\": \(lon)}".data(using: .utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }*/
    
    
    func formatAlert(_ view: UIViewController, _ nav: UINavigationController)
    {
        
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        {
            UIAlertAction in
            nav.popToRootViewController(animated: true)
            self.alert.dismiss(animated: false, completion: nil)
        }
        
        if alert.actions == []
        {
            alert.addAction(okayAction)
        }
        view.present(self.alert, animated: true, completion: nil)
    }
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
}
