//
//  Place.swift
//  WhereAmI
//
//  Created by yeshaokai on 3/2/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject,MKAnnotation {
    let title: String
    let subtitle:String
    var coordinate: CLLocationCoordinate2D
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
