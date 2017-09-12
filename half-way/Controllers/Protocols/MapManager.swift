//
//  MapManager.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

protocol MapManager {
	func showPositionOnMap(_ latitude: Double, _ longitude: Double)
	func setupView(with state: AppState)
}
