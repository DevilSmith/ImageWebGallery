//
//  WebImage.swift
//  Swift VK
//
//  Created by Stanislav Briver on 22.10.2021.
//

import Foundation

struct WebImages: Decodable{
    
    var results: [ImageResult]!
}


struct ImageResult: Decodable{
    
    var id: String
    var urls: Urls
}

struct Urls: Decodable{
    
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}


