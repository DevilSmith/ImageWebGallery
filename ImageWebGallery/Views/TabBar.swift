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
        
        
        let imagesNavigationController = UINavigationController(rootViewController: imagesView)
        imagesView.collectionView.translatesAutoresizingMaskIntoConstraints = false

        
        imagesView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        tabBar.viewControllers = [imagesNavigationController]
        
        
        self.view.addSubview(tabBar.view)
    }
        
    

    
}


