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
    
    let manager = CLLocationManager()
    
    @IBOutlet weak var instructionText: UITextView!
    
    @IBOutlet weak var locationInput: UITextField!
    
    @IBOutlet weak var urlText: UITextField!
    
    @IBOutlet weak var mapPreview: MKMapView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var pinPreview = MKPointAnnotation()
    
    let LocationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
       // formatText(locationInput, startText: "Location")
       // formatText(urlText, startText: "Your Web Link")
        
        setUserInfo()
    }
    
    func formatText(_ text: UITextField, startText: String)
    {
        text.placeholder = startText
        text.alpha = 0.5
        text.textAlignment = .center
        text.font = UIFont(name: "Helvetica", size: 20.0)
        
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
    
    func cityNameToLatLon(_ cityName: String, _ map: MKMapView){
        
        geoCoder.geocodeAddressString(cityName)
        {
        (placemarks, error) in
                let placemark = placemarks
                let location = placemark?.first?.location
                let locaLocation = location?.coordinate
        
            self.pinPreview.coordinate = locaLocation!
        }
        
        map.addAnnotation(pinPreview)
    }
    
    
    
    @IBAction func submitPin(_ sender: Any) {
        let mediaLink = urlText.text
        let locationString = locationInput.text
        let lat = pinPreview.coordinate.latitude
        let lon = pinPreview.coordinate.longitude
        
        ParseClient.sharedInstance().postLocation(lastName!, firstName!, uniqueKey!, lat, lon, mapString: locationString!, mediaURL: mediaLink!)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
}
