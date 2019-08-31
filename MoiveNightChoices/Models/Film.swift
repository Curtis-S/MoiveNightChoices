//
//  Film.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation


struct Movies: Codable{
    
    var results :[Movie]
    
}

struct Movie: Codable {
    
    let title:String
    let id:Int
    let overview:String
}
