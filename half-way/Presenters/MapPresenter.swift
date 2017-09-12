//
//  MapPresenter.swift
//  half-way
//
//  Created by Lukasz on 04/09/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation

class MapPresenter: MapViewPresenter {

	private var mapInteractor: UserLocationManager
	private var apiManager: APIManager
	private var notifier: Notifier

	init(mapInteractor: UserLocationManager, apiManager: APIManager, notifier: Notifier) {
		self.mapInteractor = mapInteractor
		self.apiManager = apiManager
		self.notifier = notifier
	}

	func setAppState(response: (AppState) -> Void) {
		guard let _ = DeepLinkHandler.shared.hash else {
			response(.Initiator)
			return
		}
		response(.Recipient)
	}

	func updatePosition() {
		mapInteractor.startUpdatePosition()
	}

	func showUserCurrentPosition(response: (_ latitude: Double, _ longitude: Double) -> Void) {
		let (lat, long) = mapInteractor.calculateCurrentPosition()
		response(lat, long)
	}

	func sharePosition(with friend: String) {
		let (lat, long) = mapInteractor.calculateCurrentPosition()
		apiManager.startCommunication(with: friend, latitude: lat, longitude: long) { response in
			let topicKey = response["topic"] as! String
			self.notifier.subscribe(to: topicKey, with: self)
		}
	}
}

extension MapPresenter: NotifierDelegate {
	
	internal func mqttNotifierDidReceive(message data: Data, in topic: String) {
		let rawData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
		print(rawData)
		print(topic)
	}
}
