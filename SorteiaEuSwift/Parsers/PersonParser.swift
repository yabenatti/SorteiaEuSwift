//
//  PersonParser.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 12/07/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

extension Person {
    class func parseToPerson(dictionary: [String : Any]) -> Person? {
        guard let twitterId = dictionary["twitterId"] as? String else {
                print("Incorret info on person parser")
                return(nil)
        }
        
        let name = dictionary["name"] as? String
        let picture = dictionary["picture"] as? String
        
        return Person.init(twitterId: twitterId, name: name, picture: picture)
    }
}
