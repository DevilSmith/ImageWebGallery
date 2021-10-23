//
//  ImageViewModel.swift
//  Swift VK
//
//  Created by Stanislav Briver on 20.10.2021.
//

import Foundation
import UIKit

class ImagePresenter{
    
    var imageArray: [ImageModel] = [
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage2")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1")),
        ImageModel(image: UIImage(named: "MockImage")),
        ImageModel(image: UIImage(named: "MockImage1"))
        
    ]
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.imageArray = [
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage")),
                ImageModel(image: UIImage(named: "MockImage"))
            ]
            print("Async image updated !")
        }
        
    }
    
}
