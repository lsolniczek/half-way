//
//  HalfWayApiClient.swift
//  half-way
//
//  Created by Lukasz on 27/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation

class HalfWayApiClient {

	typealias CompletitionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

	static let baseURL = "http://02f680de.ngrok.io"

	enum ApiError: Error {
		case NoBodyRequestError
	}

	func serviceURL(path: String) -> URL {
		fatalError("Subclass needs to provide implementation.")
	}

	func POST(path: String, body: Data, completitionHandler: @escaping CompletitionHandler) {
		doRequest(path: path, method: "POST", body: body, completitionHandler: completitionHandler)
	}

	func GET(path: String, completitionHandler: @escaping CompletitionHandler) {
		doRequest(path: path, method: "GET", body: nil, completitionHandler: completitionHandler)
	}

	private func doRequest(path: String, method: String, body: Data?, completitionHandler: @escaping CompletitionHandler) {
		let url = serviceURL(path: path)
		let session = URLSession(configuration: URLSessionConfiguration.default)
		var request = URLRequest(url: url)
		request.httpMethod = method

		if method == "POST" {
			if let body = body {
				request.httpBody = body
			} else {
				completitionHandler(nil, nil, ApiError.NoBodyRequestError)
			}
		}

		let task = session.dataTask(with: request) { (data, response, error) in
			if let error = error {
				completitionHandler(nil, nil, error)
				return
			}
			guard let response = response as? HTTPURLResponse else { return }
			if let data = data {
				completitionHandler(data, response, nil)
				return
			}
		}
		task.resume()
	}

}
