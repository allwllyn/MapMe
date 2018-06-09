//
//  WebController.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/9/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class WebController: UIViewController {
    
    
    @IBOutlet weak var webViewer: WKWebView!
    
    var request = SurfClient.sharedInstance().requestPage!
    
    override func viewWillAppear(_ animated: Bool) {
        
    webViewer.load(request)
        
    }
    
    
}
