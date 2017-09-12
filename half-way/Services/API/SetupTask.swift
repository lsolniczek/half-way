//
//  SetupTask.swift
//  half-way
//
//  Created by Lukasz on 27/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation
import PromiseKit

class SetupTask: HalfWayApiClient {

	static let shared = SetupTask()
	private override init() {
		super.init()
	}

	typealias CreateResponse = (Data, HTTPURLResponse)
	typealias SetupParseResponse = ([String: Any])

	override func serviceURL(path: String) -> URL {
		var url = URL(string: HalfWayApiClient.baseURL)
		url!.appendPathComponent(path)
		if let hash = DeepLinkHandler.shared.hash {
			url!.appendPathComponent("/" + hash)
		}
		print("url - \(url!)")
		return url!
	}

	func create(with friendEmail: String, uuid: String, latitude: Double, longitude: Double) -> Promise<SetupParseResponse> {
		return firstly { () -> Promise<Data> in
			let positions: [String: Any] = ["latitude": latitude, "longitude": longitude]
			let params: [String: Any] = ["uuid": uuid, "position": positions]
			return self.deserialize(params: params)
		}.then { (data) -> Promise<CreateResponse> in
			return self.callCreate(with: data)
		}.then(execute: { (createRespones) -> Promise<SetupParseResponse> in
			return self.serialize(data: createRespones.0, response: createRespones.1)
		})
	}

	private func deserialize(params: [String: Any]) -> Promise<Data> {
		return Promise(resolvers: { (fulfill, reject) in
			do {
				let data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
				fulfill(data)
			} catch {
				reject(error)
			}
		})
	}

	private func callCreate(with data: Data) -> Promise<CreateResponse> {
		return Promise(resolvers: { (fulfill, reject) in
			POST(path: "setup", body: data, completitionHandler: { (data, response, error) in
				if let error = error {
					reject(error)
				}
				if let data = data, let response = response {
					fulfill((data, response))
				}
			})
		})
	}

	private func serialize(data: Data, response: HTTPURLResponse) -> Promise<SetupParseResponse> {
		return Promise(resolvers: { (fulfill, reject) in
			do {
				let setupResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! SetupParseResponse
				fulfill(setupResponse)
			} catch {
				reject(error)
			}
		})
	}

}
