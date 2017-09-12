//
//  AppDelegate.swift
//  half-way
//
//  Created by Lukasz on 21/08/16.
//  Copyright © 2016 candy bar code. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var appCoordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow.init(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController()
		appCoordinator = AppCoordinator(rootViewController: self.window?.rootViewController as! UINavigationController)
		appCoordinator?.start()
		window?.makeKeyAndVisible()
		setUUID()
		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		if url.scheme == "halfway" {
			let dlHandler = DeepLinkHandler.shared
			dlHandler.hash = url.lastPathComponent
			return true
		}
		return false
	}

	private func setUUID() {
		let userDefaults = UserDefaults.standard
		guard let _ = userDefaults.object(forKey: "device-uuid") as? String else {
			let uuid = UUID().uuidString
			userDefaults.set(uuid, forKey: "device-uuid")
			return
		}
	}
}

