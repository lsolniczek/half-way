//
//  MapViewController.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	@IBOutlet var mapView: MapView!
	@IBOutlet weak var startButton: UIButton!

	var presenter: MapViewPresenter!

	init(presenter: MapViewPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.updatePosition), name: .UIApplicationWillEnterForeground, object: nil)
	}

	deinit {
		NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presenter.setAppState(response: setupView)
		presenter.updatePosition()
		presenter.showUserCurrentPosition(response: showPositionOnMap)
	}

	func updatePosition() {
		presenter.showUserCurrentPosition(response: showPositionOnMap)
	}

	@IBAction func sharePosition(_ sender: UIButton) {
		presenter.sharePosition(with: "l.solniczek@gmail.com")
	}
}

extension MapViewController: MapManager {

	func showPositionOnMap(_ latitude: Double, _ longitude: Double) {
		mapView.centerMapOnLocation(latitude: latitude, longitude: longitude)
		mapView.addAnnotationOnLocation(latitude: latitude, longitude: longitude)
	}

	func setupView(with state: AppState) {
		switch state {
		case .Initiator:
			startButton.isHidden = false
		case .Recipient:
			startButton.isHidden = true
		}
	}
}
