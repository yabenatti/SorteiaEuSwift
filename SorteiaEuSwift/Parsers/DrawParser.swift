//
//  DrawParser.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 2017-07-11.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

extension Draw {
    class func parseToDraw(dictionary: [String: Any]) -> Draw? {
        guard let profile = dictionary["profile"] as? [String: Any] else {
            print("Incorret profile info on draw parser")
            return(nil)
        }
        
        guard let person = Person.parseToPerson(dictionary: profile) else {
            print("Couldn't parse person")
            return(nil)
        }
        
        guard let disquilified = dictionary["disqualified"] as? Bool,
            let drawId = dictionary["id"] as? Int,
            let createdAt = dictionary["createdAt"] as? Int else {
                print("Incorret draw parser")
                return(nil)
        }
        
        let updatedAt = dictionary["updatedAt"] as? Int
        let disquilifiedReason = dictionary["reason"] as? String

        return Draw.init(disquilified: disquilified, id: drawId, disquilifiedReason: disquilifiedReason, createdAt: createdAt, updatedAt: updatedAt, person: person)
    }
}
