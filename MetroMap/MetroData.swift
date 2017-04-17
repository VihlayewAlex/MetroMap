//
//  MetroData.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/11/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

class MetroData {

    var cityName: String?
    var stations = [MetroStation_Vertex_]()
    
    func add(station: MetroStation_Vertex_) {
        self.stations.append(station)
    }
    
    func getWay(from firstStationIndex: Int, to secondStationIndex: Int) -> [Int]? {
        
        return nil
        
    }
    
}
