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
        if (textField.text?.characters.count as! Int) >= 6
        {
            return true
        }
        else
        {
           errorView.text = "Please enter valid password."
            return false
        }
    }
    
    func emailIsValid (_ textField: UITextField) -> Bool
    {
        if ((textField.text?.contains("@"))! && ((textField.text?.contains(".com"))! || (textField.text?.contains(".edu"))!))
        {
           
            errorView.text = "Let's map the owner of \(inputEmail.text!)!"
            return true
        }
            
        else
        {
            errorView.text = "Email invalid"
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
            loginButton.alpha = 0.3
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
        
    }
    
    func resignIfFirstResponder(_ textField: UITextField)
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
        
        else if textField == inputEmail{
            emailIsValid(textField)
        }
        else if textField == inputPassword{
            textIsValid(textField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        resignIfFirstResponder(textField)
        checkLoginText()
        
        return true
    }
    
    func checkLoginText() {
        
        if (emailIsValid(inputEmail) && textIsValid(inputPassword))
        {
           setUIEnabled(true)
        }
        else
        {
            setUIEnabled(false)
        }
    }
}

