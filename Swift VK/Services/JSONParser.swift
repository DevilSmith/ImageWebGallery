//
//  JSONParser.swift
//  Swift VK
//
//  Created by Stanislav Briver on 22.10.2021.
//

import Foundation

protocol JSONGenericParser{
    associatedtype ParserType: Decodable
    
    func loadData(urlString: String, completion: @escaping(ParserType?, Error?)->())
}

class JSONParser<ParserType:Decodable>: JSONGenericParser{
    
    func loadData(urlString: String, completion: @escaping (ParserType?, Error?)->()){
        DispatchQueue.main.async{
            
        guard let url = URL(string: urlString) else {print("Invalid urlString"); return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {print(error); completion(nil, error)}
            
            guard let data = data else {print("Invalid data"); return}
            
            do {
                let webImages = try JSONDecoder().decode(ParserType.self, from: data)
                dump(webImages)
                completion(webImages, nil)
            } catch let jsonError{
                print("JSON decoder error: ", jsonError)
            }
        }.resume()
        }
    }
    
}
