//
//  GCDBlackBox.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/20/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
