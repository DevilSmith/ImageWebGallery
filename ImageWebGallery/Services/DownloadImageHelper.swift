//
//  DownloadImageHelper.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 06.11.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import Foundation
import UIKit

class DownloadImageHelper{
    
    func downloadImage(urlString: String, completion: @escaping(UIImage?, Error?)->()){
        DispatchQueue.global(qos: .background).sync {
            
            guard let url = URL(string: urlString) else {print("Failed to loading image"); return}
            
            URLSession.shared.dataTask(with: url) { dataImage, response, error in
                
                guard let data = dataImage else {return}
                
                completion(UIImage(data: data), nil)
            }.resume()
        }
    }
    
}
