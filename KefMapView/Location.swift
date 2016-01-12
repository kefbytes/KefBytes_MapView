//
//  Location.swift
//  KefMapView
//
//  Created by Franks, Kent on 1/11/16.
//  Copyright © 2016 Franks, Kent. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
