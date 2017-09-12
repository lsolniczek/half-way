//
//  UserLocationManager.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

protocol UserLocationManager {
	func calculateCurrentPosition() -> (Double, Double)
	func canShowPosition() -> Bool
	func startUpdatePosition()
	func stopUpdatePosition()
}
