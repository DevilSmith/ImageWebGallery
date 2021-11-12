//
//  TabBar.swift
//  Swift VK
//
//  Created by Stanislav Briver on 19.10.2021.
//

import UIKit


class ApplicationTabBar: UITabBarController{
    
    let navigationViewController: NavigationController = NavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [navigationViewController]
        
    }
}


