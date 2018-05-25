//
//  TabBarVC.swift
//  BKSTestRx
//
//  Created by Тигран on 24.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let tickersVC = TickersVC()
		tickersVC.tabBarItem = UITabBarItem(title: "Котрировки", image: UIImage(named: "money"), tag: 0)
		
		let pauseVC = PauseVC()
		pauseVC.tabBarItem = UITabBarItem(title: "Пауза", image: UIImage(named: "pause"), tag: 1)
		
		let viewControllerList = [tickersVC, pauseVC]
		viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}
