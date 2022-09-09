//
//  TabbarController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let items = tabBar.items {
            // Setting the title text color of all tab bar items:
            for item in items {
                item.setTitleTextAttributes([.foregroundColor: Colors.accentColor()], for: .selected)
                item.setTitleTextAttributes([.foregroundColor: UIColor.green], for: .normal)
            }
        }
    }
}
