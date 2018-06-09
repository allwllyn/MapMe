//
//  PostPinController.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/2/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class PostPinController: UIViewController, UITextFieldDelegate {
    
    var lastName: String?
    var firstName: String?
    let uniqueKey = UdacityClient.sharedInstance().uniqueKey
    
  
    @IBOutlet weak var urlText: UITextField!
    
    @IBOutlet weak var previewMap: MKMapView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var urlInstruct: UITextView!
 
    
    
    
    var pinPreview = MapInteract.sharedInstance().pinPreview
    
    let addressString = MapInteract.sharedInstance().userAddressString
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        formatText(urlText, startText: "Your Web Link")
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
      MapInteract.sharedInstance().cityNameToLatLon(addressString!, previewMap)
        
       
        
        setUserInfo()
    }
    
    func formatText(_ text: UITextField, startText: String)
    {
        text.placeholder = startText
        text.textAlignment = .center
        text.font = UIFont(name: "Helvetica", size: 20.0)
        urlText.allowsEditingTextAttributes = true
        urlText.isUserInteractionEnabled = true
        
        urlInstruct.font = UIFont(name: "Menlo", size: 24.0)
        urlInstruct.isUserInteractionEnabled = false
        urlInstruct.allowsEditingTextAttributes = false
        urlInstruct.text = "Does this look right?"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if urlText.text != "" {
            submitButton.isEnabled = true
        }
        return true
    }
    
    func formatButton(_ button: UIButton)
    {
        
        button.setTitle("Enter Location & Link", for: .disabled)
        button.setTitle("Submit!", for: .normal)
        
        if !button.isEnabled
        {
            button.alpha = 0.5
        }
        
        else
        {
            button.alpha = 1.0
        }
        
    }
    
    @IBAction func submitPin(_ sender: Any) {
        let mediaLink = urlText.text
        let lat = pinPreview.coordinate.latitude as Double
        let lon = pinPreview.coordinate.longitude as Double
        
        ParseClient.sharedInstance().postLocation(firstName!, lastName!, uniqueKey!, lat, lon, mapString: addressString!, mediaURL: mediaLink!)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    

    
    
    
    
}
