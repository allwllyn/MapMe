//
//  loginExtension.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/26/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit


extension LoginController
{
    
    func textIsValid (_ textField: UITextField) -> Bool
    {
        if textField.text != ""
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func setUIEnabled(_ enabled: Bool)
    {
        loginButton.isEnabled = enabled
        
        // adjust login button alpha
        if enabled
        {
            loginButton.alpha = 1.0
        }
        else
        {
            loginButton.alpha = 0.5
        }
    }
    
    func displayError(_ errorString: String?)
    {
        if let errorString = errorString
        {
            errorView.text = errorString
        }
    }
    func formatText(_ text: UITextField)
    {
        text.delegate = self
        
        textFieldShouldReturn(text)        
    }
    
    func resignIfFirstResponder(_ textField: UITextField)
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        resignIfFirstResponder(textField)
        
        return true
    }
    
    func checkLoginText() {
        
        if (textIsValid(inputEmail) && textIsValid(inputEmail))
        {
            loginButton.isEnabled = true
        }
    }
}

