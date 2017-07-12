//
//  Person.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 14/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

class Person {

    var twitterId : Int = 0
    
    var name : String?
    var picture : String?
    
    
    init(twitterId: Int, name: String?, picture : String?) {
        self.twitterId = twitterId
        
        self.name = name
        self.picture = picture
    }
    
    init() {
        self.twitterId = 0
        
        self.name = ""
        self.picture = ""
    }
}
