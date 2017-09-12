//
//  MapCoordinator.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import UIKit

class MapCoordinator {

	private let rootViewController: UINavigationController

	init(rootViewController: UINavigationController) {
		self.rootViewController = rootViewController
	}

	func start() {
		let mapPresenter = MapPresenter(mapInteractor: MapInteractor(),
		                                apiManager: APIInteractor(),
		                                notifier: MQTTNotifier())
		let mapVC = MapViewController(presenter: mapPresenter)
		rootViewController.pushViewController(mapVC, animated: false)
	}

}
