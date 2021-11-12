//
//  DownloadImageService.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 06.11.2021.
//

import Foundation
import UIKit

class DownloadImageSerivce{
    
    let id = "xi_W1e0UGBk-AXb0-WIyqNDq48FjcrWD7BYxSl1P3lg"
    
    var parser = JSONParser<WebImages>()
    
    var results: [ImageModel] = []
    
    
   private func downloadImage(urlString: String, completion: @escaping(UIImage?, Error?)->()){
        DispatchQueue.global(qos: .background).sync {
        
        guard let url = URL(string: urlString) else {print("Failed to loading image"); return}
        
        URLSession.shared.dataTask(with: url) { dataImage, response, error in
            
            guard let data = dataImage else {return}
            
            completion(UIImage(data: data), nil)
        }.resume()
        }
    }
    
   private func loadDataFromResource(_ pageNumber: Int? = 1, _ querySearch: String? = "")->(){
        
        let page = pageNumber ?? 1
        
        let query = querySearch ?? ""
        
        let filteredQuery = query.filter {($0 != ".") && ($0 != " ")}
        
        print(filteredQuery)
        
        parser.loadData(urlString: "https://api.unsplash.com/search/photos?page=\(page)&query=\(filteredQuery)&client_id=\(id)") { (webImage, nil) in
            if let tempResult = webImage?.results {
                tempResult.forEach { imageResult in
                    DispatchQueue.global(qos: .background).sync{
                        self.downloadImage(urlString: imageResult.urls.small) { image, error in
                            print("Download image: \(imageResult.id)")
                            self.results.append(ImageModel(image: image))
                        }
                }
                }
            }
        }
    }
    
    func loadData(){

    }
    
    
}
