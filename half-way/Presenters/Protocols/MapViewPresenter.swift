//
//  MapViewPresenter.swift
//  half-way
//
//  Created by Lukasz on 04/09/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation

enum AppState {
	case Initiator
	case Recipient
}

protocol MapViewPresenter {
	func setAppState(response: (AppState) -> Void)
	func updatePosition()
	func showUserCurrentPosition(response: (_ latitude: Double, _ longitude: Double) -> Void)

	func sharePosition(with friend: String)
}
