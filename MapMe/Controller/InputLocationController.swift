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
    
    @IBOutlet weak var mapButton: UIButton!
    
    @IBOutlet weak var instructionText: UITextView!
    
    var addressString: String?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        formatInstruction()
        
        mapButton.setTitle("Map", for: .normal)
        mapButton.isEnabled = false
        mapButton.alpha = 0.5
        inputLocation.delegate = self
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        inputLocation.text = ""
        formatInstruction()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if inputLocation.text != "" {
            mapButton.isEnabled = true
            mapButton.alpha = 1.0
        }
        resignIfFirstResponder(textField)
        return true
    }
    
    
    func setUserLocation()
    {
    
       MapInteract.sharedInstance().userAddressString = inputLocation.text!
    }
    
    @IBAction func geocodeAddress()
    {
    
      //  MapInteract.sharedInstance().showActivity(self.view)
        
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
        inputLocation.isUserInteractionEnabled = true
        
    }
    
    @IBAction func typeLocation(_ sender: Any) {
        
        mapButton.alpha = 1.0
        mapButton.isEnabled = true
    }
    
    
    
}
