//
//  Draw.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 14/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

class Draw {
    
    var disquilified : Bool = false
    
    var disquilifiedReason : String?
    
    var id : Int = 0
    var createdAt : Int = 0
    var updatedAt : Int?
    
    var person : Person
    
    init(disquilified: Bool, id: Int, disquilifiedReason: String?, createdAt: Int, updatedAt: Int?, person: Person) {
        self.disquilified = disquilified
        
        self.id = id
        
        self.disquilifiedReason = disquilifiedReason
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.person = person
    }
}
