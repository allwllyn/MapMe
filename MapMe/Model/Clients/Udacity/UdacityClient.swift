//
//  Udacity.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/14/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation


class UdacityClient: NSObject {
    
    var uniqueKey: String?
    
    
    func postForAuth(_ username:String, _ password:String, _ completionHandler: @escaping (_ success: Bool, _ sessionID: String?, _ error: String?) -> Void)
    {
        //1. Set Parameters, ???
    
        //2-3. Build URL, Configure Request
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        
        //4. Make Request
        let task = session.dataTask(with: request)
        {
            data, response, error in
            
            //Check Error
            func sendError(_ error: String)
            {
                completionHandler(false, nil, error)
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
                sendError("Email & Password don't match any users.")
                return
            }
            
            //GUARD: Was there any data returned?
            guard let data = data else
            {
                sendError("No data was returned by the request!")
                return
            }
            
            // 5-6. Parse the data and use the data
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
            
            var parsedResult: AnyObject!
            
            do
            {
              parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as AnyObject
            }
            catch
            {
                print("could not parse data")
            }
            
            let udacitySession = parsedResult[(UdacityClient.User.session)] as! NSDictionary
        
            let udacitySessionID = udacitySession[UdacityClient.Info.ID] as! String
            
            let accountInfo = parsedResult[(UdacityClient.User.account)] as! NSDictionary
            
            self.uniqueKey = accountInfo[UdacityClient.Info.key] as! String
            
            if udacitySessionID != nil
            {
            
            completionHandler(true, udacitySessionID, nil)
            }
            else
            {
                completionHandler(false, nil, "Bad credentials")
            }
        }
        
            task.resume()

    }
    
    
    func getPublicInfo(_ key: String, _ completion: @escaping (_ publicInfo: NSDictionary,_ success: Bool) -> Void)
    {
        let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(key)")!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            let range = Range(5..<data.count)
            
            let newData = data.subdata(in: range) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
            
            var parsedResult: AnyObject?
            do
            {
            try parsedResult = JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! NSDictionary
            }
            catch
            {
                print("There was an error parsing the data")
            }
            
            let publicUserInfo = parsedResult!["user"] as! NSDictionary
            completion(publicUserInfo, true)
            
        }
        task.resume()
     }
    
    func endSession()
    {
        
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
}
