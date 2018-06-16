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
    
    let locations = MapInteract.sharedInstance().studentLocationArray
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        formatText(urlText, startText: "Your Web Link")
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        previewMap.removeAnnotations(previewMap.annotations)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        
        MapInteract.sharedInstance().cityNameToLatLon(addressString!, previewMap, self, navigationController!)
        
        setUserInfo()
    }
    
    func formatText(_ text: UITextField, startText: String)
    {
        text.placeholder = startText
        text.textAlignment = .center
        text.font = UIFont(name: "Helvetica", size: 20.0)
        urlText.allowsEditingTextAttributes = true
        urlText.isUserInteractionEnabled = true
        urlText.delegate = self
        urlInstruct.font = UIFont(name: "Menlo", size: 24.0)
        urlInstruct.isUserInteractionEnabled = false
        urlInstruct.allowsEditingTextAttributes = false
        urlInstruct.text = "Does this look right?"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if urlText.text != "" {
            submitButton.isEnabled = true
        }
        resignIfFirstResponder(textField)
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
        var alreadyMapped: Bool = false
        
      
            ParseClient.sharedInstance().postLocation(firstName!, lastName!, uniqueKey!, lat, lon, mapString: addressString!, mediaURL: mediaLink!)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    @IBAction func inputLink(_ sender: UITextField) {
        submitButton.alpha = 1.0
        submitButton.isEnabled = true
    }
    
    
    
    
    
}
