//
//  ViewController.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/11/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit
import MapKit

class MainMapVC: UIViewController {

    
    let metroDataManager = MetroDataManager.shared
    var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare map view
        mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        self.centerMapOn(location: metroDataManager.metroData!.stations.first!.location)
        // FINAL
        drawStations()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Update map view frame on orientation change
        mapView.frame = UIScreen.main.bounds
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: - MapKit features

extension MainMapVC: MKMapViewDelegate {
    
    // Draws pins for all stations
    func drawStations() {
        for station in metroDataManager.metroData!.stations {
            self.addPinFor(station: station)
        }
    }
    
    func centerMapOn(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPinFor(station: MetroStation_Vertex_) {
        let annotation = MetroStationAnnotation(pinColorString: station.color)
        annotation.coordinate = station.location.coordinate
        annotation.title = station.stationName
        
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        let colorPointAnnotation = annotation as! MetroStationAnnotation
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.canShowCallout = true
        pinView?.pinTintColor = colorPointAnnotation.pinColor
        
        return pinView
    }
    
}

