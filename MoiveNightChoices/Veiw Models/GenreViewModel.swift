//
//  GenreViewModel.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 31/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation



struct GenreViewModel:Codable {
    
    let name:String
    let id:Int
    var isChosen = false
    
}


extension GenreViewModel:Hashable {
    mutating func choseGenre(){
        self.isChosen = !self.isChosen
    }
    init(genre:Genre) {
        self.name = genre.name
        self.id = genre.id
    }
    
}

