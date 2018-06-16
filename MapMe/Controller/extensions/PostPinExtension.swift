//
//  PostPinExtension.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/2/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit

extension PostPinController
{
    
    
    
    
    func setUserInfo()
    {
        
        if uniqueKey != nil
        {
            UdacityClient.sharedInstance().getPublicInfo(uniqueKey!)
            { (publicInfo, success) in
        
                if success
                {
                    self.lastName = publicInfo["last_name"] as! String
                    self.firstName = publicInfo["nickname"] as! String
                }
            }
        }
        else
        {
            print("key is nil")
        }
    }
    
    
    func resignIfFirstResponder(_ textField: UITextField)
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
        
    }
    
    
    
    
    
}

