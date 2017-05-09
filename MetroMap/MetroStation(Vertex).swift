//
//  MetroStation(Vertex).swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/11/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit
import MapKit

class MetroStation_Vertex_: NSObject {
    // Vertex info
    let stationIndex: Int
    let connectedMetroStationsIndexes_Vertices_: [Int]
    // Metro station info
    let stationName: String
    let location: CLLocation
    let lineName: String
    // Hash
    override var hashValue: Int {
        return stationIndex
    }

    
    init(withName name: String, withLineName lineName: String, forIndex index: Int, connectedTo connections: [Int], loacatedAt coordinates: (Double,Double)) {
        // Setting vertex properties
        self.stationIndex = index
        self.connectedMetroStationsIndexes_Vertices_ = connections
        // Setting metro station properties
        self.stationName = name
        self.location = CLLocation(latitude: coordinates.0, longitude: coordinates.1)
        self.lineName = lineName
    }
    
}

func ==(lhs: MetroStation_Vertex_, rhs: MetroStation_Vertex_) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
