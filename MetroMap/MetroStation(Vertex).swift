//
//  MetroStation(Vertex).swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/11/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit
import MapKit

class MetroStation_Vertex_ {
    // Vertex info
    let stationIndex: Int
    let connectedMetroStationsIndexes_Vertices_: [Int]
    // Metro station info
    let stationName: String
    let location: CLLocation
    let color: String
    
    
    init(withName name: String, withColor color: String, forIndex index: Int, connectedTo connections: [Int], loacatedAt coordinates: (Double,Double)) {
        // Setting vertex properties
        self.stationIndex = index
        self.connectedMetroStationsIndexes_Vertices_ = connections
        // Setting metro station properties
        self.stationName = name
        self.location = CLLocation(latitude: coordinates.0, longitude: coordinates.1)
        self.color = color
    }
    
}
