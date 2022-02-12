//
//  ImageView.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 06.11.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import UIKit

class ImageView: UIViewController{
    
    let image: UIImage
    
    let imageView: UIImageView
    
    func setupImageView(){
        self.imageView.contentMode = .scaleAspectFill
    }
    
    init(image: UIImage){
        self.image = image
        self.imageView = UIImageView(image: image)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: +200).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        
        setupImageView()
        
        self.view.addSubview(imageView)
        
        setupConstraint()
        
        print(image)
        
        
    }
}
