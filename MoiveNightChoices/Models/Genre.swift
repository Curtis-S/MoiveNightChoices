//
//  Genre.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation


struct Genres:Codable {
    var genres: [Genre]
    
}


struct Genre:Codable {
    
    let name:String
    let id:Int

    
}


extension Genre:Hashable {
 

}
