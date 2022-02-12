//
//  WebImageViewModel.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 22.10.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import Foundation
import UIKit

class WebImagePresenter: ImageCollectionViewUpdateDelegate{
    
    let id = "xi_W1e0UGBk-AXb0-WIyqNDq48FjcrWD7BYxSl1P3lg"
    
    var collectionView: UICollectionView!
    
    private var increaseCounter = 1
    
    var downloadImageHelper = DownloadImageHelper()
    var parser = JSONParser<WebImages>()
    
    var results: [ImageModel] = []
    
    private var counter = 0
    
    func loadDataFromResource(_ pageNumber: Int? = 1, _ querySearch: String? = "")->Void{
        
        let page = pageNumber ?? 1
        
        let query = querySearch ?? ""
        
        let filteredQuery = query.filter {($0 != ".") && ($0 != " ")}
        
        #if DEBUG
        print(filteredQuery)
        #endif
        
        parser.loadData(urlString: "https://api.unsplash.com/search/photos?page=\(page)&query=\(filteredQuery)&client_id=\(id)") { (webImage, nil) in
            if let tempResult = webImage?.results {
                tempResult.forEach { imageResult in
                    DispatchQueue.global(qos: .background).sync{
                        self.downloadImageHelper.downloadImage(urlString: imageResult.urls.regular) { image, error in
                            #if DEBUG
                            print("Download image: \(imageResult.id)")
                            #endif
                            self.results.append(ImageModel(image: image!))
                            DispatchQueue.main.async{
                                self.updateCollectionView()
                            }
                        }
                }
                }
            }
        }
    }
    
    func updateCollectionView() {
        self.collectionView.reloadData()
        #if DEBUG
        print("Updated")
        #endif
    }
    
    func increaseDataLoading(){
        DispatchQueue.main.async{
            #if DEBUG
            print(self.increaseCounter)
            #endif
///     Enable infinity scrolling update data in CollectionView
///     --->       self.loadDataFromResource(self.increaseCounter)
            self.increaseCounter += 1
        }
    }
    
    func deleteData(){
        results = []
    }
    
}
