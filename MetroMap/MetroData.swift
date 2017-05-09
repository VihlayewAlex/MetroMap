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

    var ways = [[MetroStation_Vertex_]]()
    func getWay(from firstStation: MetroStation_Vertex_, to secondStation: MetroStation_Vertex_, visited: Set<MetroStation_Vertex_>, way: [MetroStation_Vertex_]) -> [MetroStation_Vertex_]? {

        var visitedStations = visited

        if firstStation == secondStation {
            return []
        }

        // Clearing visited stations set on first run
        if visitedStations.isEmpty {
            ways.removeAll()
        }
        // Adding current source
        visitedStations.insert(firstStation)

        // Iterating through connected stations
        for connectedStation in getSubVertices(forSource: firstStation) {
            // If station is not visited yet
            if !visitedStations.contains(connectedStation) {
                // Getting way between current station and destination
                if let newWay = getWay(from: connectedStation, to: secondStation, visited: visitedStations, way: way + [connectedStation]) {
                    // If we are in destination, return way
                    if newWay.isEmpty { ways.append(way) }
                }
            }
        }

        if ways.count == 0 { return nil }
        print(ways.map({ $0.map({ $0.stationName }) }))
        return ways.sorted(by: { $0.count < $1.count }).first
    }

    func getSubVertices(forSource sourceVertex: MetroStation_Vertex_) -> [MetroStation_Vertex_] {
        return stations.filter({ $0.connectedMetroStationsIndexes_Vertices_.contains(sourceVertex.stationIndex) })
    }


}
