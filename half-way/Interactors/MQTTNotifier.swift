//
//  MQTTNotifier.swift
//  half-way
//
//  Created by Lukasz on 10/09/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import Foundation
import Moscapsule

class MQTTNotifier: Notifier {

	private var session: MQTTSession
	private var config: MQTTConfig


	init() {
		session = MQTTSession(host: "tcp://139.59.150.73", port: 1883, clientID: "half-way", cleanSession: true, keepAlive: 90)
		session.username = "half-way-codequest"
		session.password = "password1"
		session.delegate = self
	}

	func subscribe(to topic: String, with delegate: NotifierDelegate) {
		self.delegate = delegate
		session.subscribe(to: topic, delivering: .atLeastOnce) { (success, error) in
			if success {
				print("Subscribed")
			}
		}
	}

	func publish(with topic: String, payload: Data) {
		session.publish(payload, in: topic, delivering: .atLeastOnce, retain: false, completion: nil)
	}

	func disconnect() {
		session.disconnect()
	}
}

extension MQTTNotifier: MQTTSessionDelegate {

	func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
		print(message)
	}

	func mqttDidDisconnect(session: MQTTSession) {

	}

	func mqttSocketErrorOccurred(session: MQTTSession) {

	}
}
