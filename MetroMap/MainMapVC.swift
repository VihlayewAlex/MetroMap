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

// MARK: - Properties

    let metroDataManager = MetroDataManager.shared
    var mapView: MKMapView!
    var bottomRouteView: BottomRouteView!
    var detailedWayButton: UIButton!
    // Stations
    var startStation: MetroStation_Vertex_?
    var endStation: MetroStation_Vertex_?
    // Current route
    var currentPolyline: MKPolyline?


// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare map view
        mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        // Prepare bottom route view
        bottomRouteView = Bundle.main.loadNibNamed("BottomRouteView", owner: self, options: nil)?.first as! BottomRouteView
        bottomRouteView.frame = CGRect(x: 0, y: view.frame.height - bottomRouteView.frame.height + 50, width: view.frame.width, height: bottomRouteView.frame.height)
        bottomRouteView.delegate = self
        self.view.addSubview(bottomRouteView)

        // Prepare detailed way button
        detailedWayButton = UIButton(frame: CGRect(origin: CGPoint(x: 5, y: 25), size: CGSize(width: 50, height: 50)))
        detailedWayButton.backgroundColor = UIColor.white
        detailedWayButton.setImage(UIImage(named: "arrows"), for: .normal)
        detailedWayButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        detailedWayButton.layer.cornerRadius = detailedWayButton.frame.height / 2
        detailedWayButton.layer.shadowPath = UIBezierPath(rect: detailedWayButton.bounds).cgPath
        detailedWayButton.layer.shadowColor = UIColor.black.cgColor
        detailedWayButton.layer.shadowRadius = 10
        detailedWayButton.layer.shadowOpacity = 0.15
        detailedWayButton.layer.shadowOffset = CGSize.zero
        detailedWayButton.addTarget(self, action: #selector(showDetailedWay), for: .touchUpInside)
        self.view.addSubview(detailedWayButton)

        // Center map
        self.centerMapOn(location: metroDataManager.metroData!.stations.first!.location)

        // Drawing stations
        drawStations()
    }


    func showDetailedWay() {

        if let start = startStation, let end = endStation {
            if start != end {
                performSegue(withIdentifier: "detailedWaySegue", sender: self)
            } else {
                let alert = UIAlertController(title: "Select diferent stations", message: "Start and destination stations can`t be same", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Select both stations", message: "Both start and destination stations must be selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedWaySegue" {
            let navigationController = segue.destination as! UINavigationController
            let destinationVC = navigationController.viewControllers.first as! DetailedWayController
            if let way = MetroDataManager.shared.metroData?.getWay(from: startStation!, to: endStation!, visited: [], way: []) {
                let finalWay = [startStation!] + way + [endStation!]
                // Setting way
                destinationVC.way = finalWay
            } else { print("Shit happens") }
        }
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

    func draw(way: [MetroStation_Vertex_]) {
        if let polyline = currentPolyline {
            mapView.remove(polyline)
        }
        var coordinates = [CLLocationCoordinate2D]()
        for station in way {
            coordinates.append(station.location.coordinate)
        }
        let wayPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        currentPolyline = wayPolyline
        mapView.add(wayPolyline)
    }
    
    func centerMapOn(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPinFor(station: MetroStation_Vertex_) {
        let annotation = MetroStationAnnotation(pinColorString: station.lineName)
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

    func mapView(_ mapView: MKMapView, viewForOverlay overlay: Any) -> MKPolylineRenderer {
        // create a polylineView using polyline overlay object
        let polylineView = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        // Custom polylineView
        polylineView.strokeColor = UIColor.orange
        polylineView.lineWidth = 5.0
        polylineView.alpha = 8.0
        return polylineView
    }

    func calculateWay(from start: MetroStation_Vertex_, to end: MetroStation_Vertex_) {
        if let way = MetroDataManager.shared.metroData?.getWay(from: start, to: end, visited: [], way: []) {
            let finalWay = [start] + way + [end]
            print(finalWay.map({ $0.stationName }))
            // Drawing
            draw(way: finalWay)
        } else { print("Shit happens") }
    }
    
}


// MARK: - BottomRouteViewDelegate

extension MainMapVC: BottomRouteViewDelegate {
    
    func startButtonDidTouched() {
        let stationChooserView = StationChooserView(frame: self.view.bounds.insetBy(top: 25, right: 15, bottom: 15, left: 15))
        stationChooserView.stationType = .Start
        stationChooserView.delegate = self

        view.addSubview(stationChooserView)
    }

    func endButtonDidTouched() {
        let stationChooserView = StationChooserView(frame: self.view.bounds.insetBy(top: 25, right: 15, bottom: 15, left: 15))
        stationChooserView.stationType = .End
        stationChooserView.delegate = self

        view.addSubview(stationChooserView)
    }
    
    func calculateWayButtonTapped() {
        if let start = startStation, let end = endStation {
            if start != end {
                calculateWay(from: start, to: end)
            } else {
                let alert = UIAlertController(title: "Select diferent stations", message: "Start and destination stations can`t be same", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Select both stations", message: "Both start and destination stations must be selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}


// MARK: - StationChooserViewDelegate

extension MainMapVC: StationChooserViewDelegate {

    func choosedStart(station: MetroStation_Vertex_?) {
        self.startStation = station
        self.bottomRouteView.startLabel.text = station?.stationName
        self.bottomRouteView.startLabel.textColor = UIColor.darkGray
    }

    func choosedEnd(station: MetroStation_Vertex_?) {
        self.endStation = station
        self.bottomRouteView.endLabel.text = station?.stationName
        self.bottomRouteView.endLabel.textColor = UIColor.darkGray
    }

}


