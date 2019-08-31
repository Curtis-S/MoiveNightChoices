//
//  Endpoint.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation



protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum MoviesDB {
    case genre
    case search(ids: [Int])
}

extension MoviesDB: Endpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .search: return "/3/discover/movie"
        case .genre: return "/3/genre/movie/list"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let ids):
            var result = [URLQueryItem]()
            
            let searchTermItem = URLQueryItem(name: "with_genres", value: ids.map{String($0)}.joined(separator: ","))
            result.append(searchTermItem)
           
            //sort_by=popularity.desc
            let sortOrderTermItem = URLQueryItem(name: "sort_by", value: "popularity.desc")
            result.append(sortOrderTermItem)
            
                let apiKey = URLQueryItem(name: "api_key", value: "e359291574602673ef4b017dcf3abf88")
                result.append(apiKey)
                
            
            return result
        case .genre:
            return [
                URLQueryItem(name: "api_key", value: "e359291574602673ef4b017dcf3abf88")
            ]
        }
    }
}
