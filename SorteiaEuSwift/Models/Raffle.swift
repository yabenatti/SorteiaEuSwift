//
//  Raffle.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 14/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

class Raffle {
    
    var drawn : Bool = false
    
    var raffleId : String = ""
    var name : String = ""
    var type : String = ""
    var url : String?
    
    var createdAt : Int = 0
    var updatedAt : Int?
    
    var draws : [Draw]?
    

    init(drawn : Bool, raffleId : String, name : String, type : String, url : String?, createdAt : Int, updatedAt : Int?, draws: [Draw]?) {
        self.drawn = drawn
        
        self.raffleId = raffleId
        self.name = name
        self.type = type
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        if let draws = draws {
            self.draws = draws
        }
    }
}
