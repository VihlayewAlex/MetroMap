//
//  MetroDataManager.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/11/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

class MetroDataManager {

    // Singletone stuff
    static let shared = MetroDataManager()
    private init() { }
    
    // Properties
    lazy var metroData: MetroData? = {
        var data: MetroData?
        
        // Reading file
        let localURL = Bundle.main.url(forResource: "Kyiv", withExtension: "json")
        let fileData: Data?
        do {
            fileData = try Data(contentsOf: localURL!)
        } catch {
            print("Read data error")
            return MetroData()
        }
        
        // Serializing JSON
        do {
            let json = try JSONSerialization.jsonObject(with: fileData!, options: .mutableContainers)
            data = self.metroDataFrom(json)
        } catch {
            print("Json serializing error")
        }
            
        return data
    }()
    
    
}


// MARK: - Serializing metro data json

extension MetroDataManager {
    
    func metroDataFrom(_ jsonData: Any) -> MetroData {
        let newCityData = MetroData()
        
        if let cityData = jsonData as? Dictionary<String, Any> {
            let city = cityData["city"] as! String
            let metroData = cityData["data"] as! [Dictionary<String, Any>]
            
            for lineData in metroData {
                let color = lineData["color"] as! String
                let stations = lineData["stations"] as! [Dictionary<String, Any>]
                
                for station in stations {
                    let index = station["index"] as! Int
                    let connections = station["connections"] as! [Int]
                    let name = station["name"] as! String
                    let latitude = station["latitude"] as! Double
                    let longtitude = station["longtitude"] as! Double
                    
                    newCityData.cityName = city
                    newCityData.add(station: MetroStation_Vertex_(withName: name, withColor: color, forIndex: index, connectedTo: connections, loacatedAt: (latitude,longtitude)))
                }
            }
        }
        
        return newCityData
    }
    
}





