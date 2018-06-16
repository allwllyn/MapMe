//
//  inputLocationExtension.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 6/16/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit

extension InputLocationController {
    func resignIfFirstResponder(_ textField: UITextField)
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
        
    }
}
