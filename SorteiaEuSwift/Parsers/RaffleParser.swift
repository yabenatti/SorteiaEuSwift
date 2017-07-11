//
//  RaffleParser.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 11/07/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation

extension Raffle {
    class func parseToRaffle(dictionary: [String: Any]) -> Raffle? {
        guard let drawn = dictionary["drawn"] as? Bool,
              let raffleId = dictionary["hash"] as? String,
              let name = dictionary["name"] as? String,
              let type = dictionary["type"] as? String,
              let createdAt = dictionary["createdAt"] as? Int else {
                print("Could not parse json into raffle")
                return(nil)
        }
        
        let url = dictionary["url"] as? String
        let updatedAt = dictionary["updatedAt"] as? Int
        
        return Raffle.init(drawn: drawn, raffleId: raffleId, name: name, type: type, url: url, createdAt: createdAt , updatedAt: updatedAt)
    }
}
