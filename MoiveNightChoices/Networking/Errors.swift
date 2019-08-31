//
//  Errors.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 31/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation


enum MovieDBError:Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message: String)
    
}
