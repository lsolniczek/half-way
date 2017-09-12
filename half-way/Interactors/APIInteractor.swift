//
//  CommunicationViewModel.swift
//  half-way
//
//  Created by Lukasz on 23/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import PromiseKit

class APIInteractor: APIManager {

	func startCommunication(with friend: String, latitude: Double, longitude: Double, responseHandler: @escaping ([String: Any]) -> Void) {
		let userDefaults = UserDefaults.standard
		let uuid = userDefaults.object(forKey: "device-uuid") as! String
		SetupTask.shared.create(with: friend, uuid: uuid, latitude: latitude, longitude: longitude)
		.then { (response) -> Promise<String> in
			responseHandler(response)
			return Promise(value: "resolved")
		}.catch { (error) in
			print(error)
		}
	}
}
