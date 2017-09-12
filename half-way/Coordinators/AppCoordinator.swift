//
//  AppCoordinatora.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import UIKit

class AppCoordinator {

	private let rootViewController: UINavigationController

	init(rootViewController: UINavigationController) {
		self.rootViewController = rootViewController
	}

	func start() {
		showMap()
	}

	private func showMap() {
		let mapCoordinator = MapCoordinator(rootViewController: rootViewController)
		mapCoordinator.start()
	}

}
