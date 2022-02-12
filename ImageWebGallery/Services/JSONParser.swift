//
//  JSONParser.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 22.10.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import Foundation

protocol JSONGenericParser{
    
    associatedtype ParserType: Decodable
    
    func loadData(urlString: String, completion: @escaping(ParserType?, Error?)->())
}

class JSONParser<ParserType:Decodable>: JSONGenericParser{
    
    func loadData(urlString: String, completion: @escaping (ParserType?, Error?)->()){
        DispatchQueue.main.async{
            
            guard let url = URL(string: urlString) else {
                #if DEBUG
                print("Invalid urlString")
                #endif
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    #if DEBUG
                    print(error)
                    #endif
                    completion(nil, error)
                    
                }
                
                guard let data = data else {print("Invalid data"); return}
                
                do {
                    let webImages = try JSONDecoder().decode(ParserType.self, from: data)
                    #if DEBUG
                    dump(webImages)
                    #endif
                    completion(webImages, nil)
                } catch let jsonError{
                    #if DEBUG
                    print("JSON decoder error: ", jsonError)
                    #endif
                }
            }.resume()
        }
    }
    
}
