//
//  ViewController.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/14/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate, UITabBarDelegate
{
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loginButton.setTitle("Login",for: UIControlState.normal)
        setUIEnabled(false)
        
        formatText(inputEmail)
        formatText(inputPassword)
        inputPassword.isSecureTextEntry = true
        
        
        errorView.text = "Let's get Mapped!"
        errorView.textAlignment = .center
        errorView.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearText()
        errorView.text = "Let's get Mapped!"
        setUIEnabled(false)
    }
    
    @IBAction func pressLogin(_ sender: Any)
    {
        let userName = inputEmail.text!
        let passWord = inputPassword.text!
        
        
       UdacityClient.sharedInstance().postForAuth(userName, passWord)
        {
            (success, sessionID, error) in
                performUIUpdatesOnMain
                    {
                        if success
                        {
                     
                            self.errorView.text = "Logging in. . . "
                            
                     let controller =   self.storyboard?.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
                            
                           self.present(controller, animated: true, completion: nil)
                        }
                        else
                        {
                            self.errorView.text = error
                        }
            }
        }
   }
    

    @IBAction func activateLogin(_ sender: Any) {
        
        setUIEnabled(true)
        
    }
    
    
    func clearText()
    {
        inputEmail.text = nil
        inputPassword.text = nil
    }

    
}

