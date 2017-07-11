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
    
    var id : Int = 0
    
    var disquilifiedReason : String? = nil
    var createdAt : String? = nil
    var updatedAt : String? = nil
    
    var person : Person
    
    init(disquilified: Bool?, id: Int, disquilifiedReason: String?, createdAt: String, updatedAt: String?, person: Person) {
        self.disquilified = disquilified!
        
        self.id = id
        
        self.disquilifiedReason = disquilifiedReason
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.person = person
    }
}
