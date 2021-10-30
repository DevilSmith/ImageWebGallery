//
//  TabBar.swift
//  Swift VK
//
//  Created by Stanislav Briver on 19.10.2021.
//

import UIKit


class ApplicationTabBar: UITabBarController{

   
//    let imagesView = ImageCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
    
    let navigationViewController: UINavigationController = {
        let imagesView = ImageCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        imagesView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let nvContoller = UINavigationController(rootViewController: imagesView)
        nvContoller.navigationBar.prefersLargeTitles = true
        
        return nvContoller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let imagesNavigationController = UINavigationController(rootViewController: imagesView)
//        imagesNavigationController.navigationBar.prefersLargeTitles = true

        
//        imagesView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.viewControllers = [navigationViewController]
        
    }
        
    

    
}


