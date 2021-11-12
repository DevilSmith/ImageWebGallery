//
//  NavigationController.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 12.11.2021.
//

import UIKit


class NavigationController: UINavigationController {
    
    
    let imageView: ImageCollectionView = {
        let imageView = ImageCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        imageView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return imageView
    }()
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.pushViewController(imageView, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
