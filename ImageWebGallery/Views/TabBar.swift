//
//  TabBar.swift
//  Swift VK
//
//  Created by Stanislav Briver on 19.10.2021.
//

import UIKit


class ApplicationTabBar: UIViewController{

   
    let imagesView = ImageCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = UITabBarController()
        
        imagesView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        tabBar.viewControllers = [imagesView]
        
        
        self.view.addSubview(tabBar.view)
    }
        
    

    
}


