//
//  WebImageViewModel.swift
//  Swift VK
//
//  Created by Stanislav Briver on 22.10.2021.
//

import Foundation
import UIKit

class WebImageViewModel{
    
    var webImage: WebImages?
    var parser = JSONParser<WebImages>()
    
    var results: [ImageModel] = []
    
    private var counter = 0
    
    
    func downloadImage(urlString: String, completion: @escaping(UIImage?, Error?)->()){
        DispatchQueue.global(qos: .background).sync {
        
        guard let url = URL(string: urlString) else {print("Failed to loading image"); return}
        
        URLSession.shared.dataTask(with: url) { dataImage, response, error in
//            print("Download image...")
            
            guard let data = dataImage else {return}
            
            completion(UIImage(data: data), nil)
        }.resume()
        }
    }
    
    
    func loadDataFromResource()->(){
        
        parser.loadData(urlString: "https://api.unsplash.com/search/photos?page=1&query=london&client_id=xi_W1e0UGBk-AXb0-WIyqNDq48FjcrWD7BYxSl1P3lg") { (webImage, nil) in
            if let tempResult = webImage?.results {
                tempResult.forEach { imageResult in
                    DispatchQueue.global(qos: .background).sync{
                        self.downloadImage(urlString: imageResult.urls.regular) { image, error in
                            print("Download image: \(imageResult.id)")
                            self.results.append(ImageModel(image: image))
                        }
                       
                }
                }
            }
        }
    }
    
}
