//
//  InputLocationController.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/3/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class InputLocationController: UIViewController, MKMapViewDelegate, UITextFieldDelegate
{
    
    @IBOutlet weak var inputLocation: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var instructionText: UITextView!
    
    var addressString: String?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        formatInstruction()
        
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        inputLocation.delegate = self
         
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if inputLocation.text != "" {
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        }
        return true
    }
    
    
    func setUserLocation()
    {
       MapInteract.sharedInstance().userAddressString = inputLocation.text!
        
    }
    
    @IBAction func geocodeAddress()
    {
    
        setUserLocation()
        
        let nextController = storyboard?.instantiateViewController(withIdentifier: "PostPinController")
        
        self.navigationController?.pushViewController(nextController!, animated: true)
    
    }
    
    func formatInstruction() {
        
        instructionText.text = "Where are you?"
        instructionText.font = UIFont(name: "Menlo", size: 24.0)
        instructionText.textAlignment = .center
        instructionText.allowsEditingTextAttributes = false
        instructionText.isUserInteractionEnabled = false
        
        inputLocation.placeholder = "City"
        
    }
    
    
    
    
    
}
