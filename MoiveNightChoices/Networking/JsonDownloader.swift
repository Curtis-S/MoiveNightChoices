//
//  JsonDownloader.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 31/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation

class JSONDownloader {
    let session: URLSession
    let decoder = JSONDecoder()
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    func jsonTask<T:Codable>(with request: URLRequest, ofType:T.Type, completionHandler completion: @escaping (T?, MovieDBError?) -> Void ) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil,.requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    print("gotdata")
                    do {
                        let returnClass = try self.decoder.decode( T.self, from: data)
                        completion(returnClass, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
    
    
    
    
    
    
    
}
