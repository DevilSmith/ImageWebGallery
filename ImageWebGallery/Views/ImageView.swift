//
//  ImageView.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 06.11.2021.
//

import Foundation
import UIKit


class ImageView: UIViewController{
    
    let image: UIImage
    
    init(image: UIImage){
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        
        let imageView = UIImageView(image: image)
        
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: +200).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        print(image)
        


        
//        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
       
        
    }
    
    
}
