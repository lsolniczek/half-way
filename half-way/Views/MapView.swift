//
//  MapView.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import UIKit
import MapKit

class MapView: MKMapView {

	func centerMapOnLocation(latitude: Double, longitude: Double) {
		let radius: CLLocationDistance = 1000
		let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius * 2, radius * 2)
		setRegion(region, animated: true)
	}

	func addAnnotationOnLocation(latitude: Double, longitude: Double) {
		let annotation = MKPointAnnotation()
		annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		addAnnotation(annotation)
	}

}
