//
//  MovieDbApi.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation


class MovieDBApiClient {
    let downloader = JSONDownloader()
    
    

    
    func getReleventDataRequest<T:Codable>(with endpoint: Endpoint, type: T.Type, completion: @escaping (T?, MovieDBError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request, ofType: type) { array, error in
            
                guard let result = array else {
                    completion(nil, error)
                    print(error?.localizedDescription)
                    return
                }
            print("got data")
                completion(result, nil)
            
        }
        
        task.resume()
        print("started task")
        
    }
}





