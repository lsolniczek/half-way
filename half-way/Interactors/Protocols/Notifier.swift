//
//  NotificationManager.swift
//  half-way
//
//  Created by Lukasz on 10/09/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation

protocol NotifierDelegate: class {
	func mqttNotifierDidReceive(message data: Data, in topic: String)
}

protocol Notifier {
	func subscribe(to topic: String, with delegate: NotifierDelegate)
	func publish(with topic: String, payload: Data)
	func disconnect()
}
