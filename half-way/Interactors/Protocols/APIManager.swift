//
//  UserCommuniationManager.swift
//  half-way
//
//  Created by Lukasz on 23/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

protocol APIManager {
	func startCommunication(with friend: String, latitude: Double, longitude: Double, responseHandler: @escaping ([String: Any]) -> Void)
}
