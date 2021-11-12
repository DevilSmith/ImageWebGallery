//
//  TabBar.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 19.10.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import UIKit


class ApplicationTabBar: UITabBarController{
    
    let navigationViewController: NavigationController = NavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [navigationViewController]
        
    }
}


