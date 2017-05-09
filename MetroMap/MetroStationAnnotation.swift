//
//  MetroStationAnnotation.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/16/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit
import MapKit

class MetroStationAnnotation: MKPointAnnotation {

    var pinColor: UIColor
    var pinColorName: String?
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
    
    init(pinColorString: String) {
        pinColorName = pinColorString
        switch pinColorString {
        case "green":
            self.pinColor = UIColor.green
        case "blue":
            self.pinColor = UIColor.blue
        case "red":
            self.pinColor = UIColor.red
        default:
            self.pinColor = UIColor.gray
        }
        super.init()
    }
    
}
