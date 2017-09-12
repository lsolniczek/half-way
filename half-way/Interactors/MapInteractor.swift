//
//  MapViewModel.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import CoreLocation

class MapInteractor: NSObject, UserLocationManager {

	private let lm = CLLocationManager()

	override init() {
		super.init()
		lm.delegate = self
	}

	func calculateCurrentPosition() -> (Double, Double) {
		guard let locCoord = lm.location?.coordinate else {
			return (0.0, 0.0)
		}
		return (locCoord.latitude, locCoord.longitude)
	}

	func startUpdatePosition() {
		askUserForPermission()
		lm.startUpdatingLocation()
	}

	func stopUpdatePosition() {
		lm.stopUpdatingLocation()
	}

	private func askUserForPermission() {
		guard canShowPosition() else {
			lm.requestWhenInUseAuthorization()
			return
		}
	}

	func canShowPosition() -> Bool {
		return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
	}
}

extension MapInteractor: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if canShowPosition() {
			startUpdatePosition()
		}
	}
}
