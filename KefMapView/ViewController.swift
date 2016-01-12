//
//  ViewController.swift
//  KefMapView
//
//  Created by Franks, Kent on 1/11/16.
//  Copyright © 2016 Franks, Kent. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    let charlotteLocation = CLLocation(latitude: 35.227085, longitude: -80.843124)
    let displaySize: CLLocationDistance = 2000
    
    let noDa = Location(
        title: "NoDa Brewing Company",
        coordinate: CLLocationCoordinate2D(latitude: 35.240348, longitude: -80.814849),
        info: "Laid-back barroom overlooking a local brewery (which offers free tours) with periodic live music."
    )
    let oldeMeck = Location(
        title: "Olde Mecklenburg Brewery",
        coordinate: CLLocationCoordinate2D(latitude: 35.187449, longitude: -80.881815),
        info: "DRINKING FRESH BEER NEVER GETS OLD"
    )
    let rockBottom = Location(
        title: "Rock Bottom Restaurant and Brewery",
        coordinate: CLLocationCoordinate2D(latitude: 35.230190, longitude: -80.839603),
        info: "Brewpub chain serving house beers & upscale pub food & American fare in lively environs."
    )
    let sugarCreek = Location(
        title: "Sugar Creek Brewing Company",
        coordinate: CLLocationCoordinate2D(latitude: 35.185421, longitude: -80.880985),
        info: "Rustic brewery & taproom offering craft & imported beer alongside simple appetizer fare."
    )
    let tripleC = Location(
        title: "Triple C Brewing Company",
        coordinate: CLLocationCoordinate2D(latitude: 35.201092, longitude: -80.869570),
        info: "Dog-friendly brewpub offering varied beers in cozy, industrial digs complete with games & a patio."
    )

    var locations:[Location]?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        centerMapOnLocation(charlotteLocation)
        
        // You can add the annotations individually
//        mapView.addAnnotation(noDa)
//        mapView.addAnnotation(oldeMeck)
//        mapView.addAnnotation(rockBottom)
//        mapView.addAnnotation(sugarCreek)
//        mapView.addAnnotation(tripleC)
        
        // Or you can add them all as an array
        locations = [noDa, oldeMeck, rockBottom, sugarCreek, tripleC]
        mapView.addAnnotations(locations!)
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (locations?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let location: Location = locations![indexPath.row]
        
        cell.textLabel!.text = location.title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let location: Location = locations![indexPath.row]
        let centerLocation = CLLocation(coordinate: location.coordinate, altitude: 1, horizontalAccuracy: 1, verticalAccuracy: -1, timestamp: NSDate())
        centerMapOnLocation(centerLocation)
        
    }
    
    // MARK: - Map Functions
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            displaySize * 2, displaySize * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Location {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            
            view.pinTintColor = UIColor.blueColor()
            return view
        }
        return nil
    }
    
}

