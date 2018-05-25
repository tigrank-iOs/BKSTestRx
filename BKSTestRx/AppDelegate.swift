//
//  AppDelegate.swift
//  BKSTestRx
//
//  Created by Тигран on 24.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		let tabBarVC = TabBarVC()
		window?.rootViewController = tabBarVC
		window?.makeKeyAndVisible()
		
		return true
	}

}

