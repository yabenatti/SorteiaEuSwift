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
    
    var createdAt : Int? = nil
    var updatedAt : Int? = nil
    
    var person : Person
    
    init(disquilified: Bool?, id: Int, disquilifiedReason: String?, createdAt: Int, updatedAt: Int?, person: Person) {
        self.disquilified = disquilified!
        
        self.id = id
        
        self.disquilifiedReason = disquilifiedReason
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.person = person
    }
    
    init() {
        self.disquilified = false
        
        self.id = 0
        
        self.disquilifiedReason = ""
        
        self.createdAt = 0
        self.updatedAt = 0
        
        self.person = Person()
    }
}
