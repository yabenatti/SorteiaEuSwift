//
//  RaffleManager.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 11/07/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation
import Alamofire

class RaffleManager {
    static let shared = RaffleManager()
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func disquilifyDrawOnRaffle(drawId: Int, raffleId: String, reason: String, completionHandler: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        if let token = AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as? String {
            manager.adapter = AccessTokenAdapter(accessToken: token)
        }
        
        let parameters : Parameters = ["reason" : reason];
        
        manager.request(Urls.URL_RAFFLE + "/" + raffleId + "/draws/\(drawId)", method: .put, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: { (response) in
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                    completionHandler(false, response.error!)
                }
            }
            
            guard response.result.isSuccess else {
                print(response.result.isFailure.description)
                completionHandler(false, response.error!)
                return
            }
            
            completionHandler(true, nil)
            
        })
    }
    
    
    func getDrawFromRaffle(raffleID: String, completionHandler: @escaping (_ draws: [Draw]?, _ count: Int, _ success: Bool, _ error: Error?) -> ()) {
        if let token = AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as? String {
            manager.adapter = AccessTokenAdapter(accessToken: token)
        }
        
        manager.request(Urls.URL_RAFFLE + "/" + raffleID + "/draws").validate().responseJSON { (response) in
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                    completionHandler(nil, 0, false, response.error!)
                }
            }
            
            guard response.result.isSuccess else {
                print(response.result.isFailure.description)
                completionHandler(nil, 0, false, response.error!)
                return
            }
            
            // to get JSON return value
            guard let responseJSON = response.result.value as? [String : Any],
                let dataJSON = responseJSON["data"] as? [String : Any] else {
                    print("Invalid specific draw information received from the service")
                    completionHandler(nil, 0, false, nil)
                    return
            }
            
            debugPrint(dataJSON)
            var drawsArray = [Draw]()
            
            guard let count = dataJSON["count"] as? Int else {
                completionHandler(nil, 0, true, nil)
                return
            }
            
            guard let list = dataJSON["list"] as? [[String : Any]] else {
                print("Couldn't handle list of raffles")
                return
            }
            
            for drawDictionary in list {
                if let draw = Draw.parseToDraw(dictionary: drawDictionary) {
                    drawsArray.append(draw)
                }
            }
            
            completionHandler(drawsArray, count, true, nil)

        }
    }
    
    func getSpecificRaffle(raffleID: String, completionHandler: @escaping (_ raffle: Raffle?, _ success: Bool, _ error: Error?) -> ()) {
        if let token = AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as? String {
            manager.adapter = AccessTokenAdapter(accessToken: token)
        }
        
        manager.request(Urls.URL_RAFFLE + "/" + raffleID).validate().responseJSON { (response) in
            debugPrint(response)
            
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                    completionHandler(nil, false, response.error!)
                }
            }
            
            guard response.result.isSuccess else {
                print(response.result.isFailure.description)
                completionHandler(nil, false, response.error!)
                return
            }
            
            // to get JSON return value
            guard let responseJSON = response.result.value as? [String : Any],
                let dataJSON = responseJSON["data"] as? [String : Any] else {
                    print("Invalid specific raffle information received from the service")
                    completionHandler(nil, false, nil)
                    return
            }
            
            debugPrint(dataJSON)
            if let raffle = Raffle.parseToRaffle(dictionary: dataJSON) {
                completionHandler(raffle, true, nil)
            } else {
                completionHandler(nil, true, nil)
            }
        }
    }
    
    func getRaffles(completionHandler: @escaping (_ raffles: [Raffle]?, _ count: Int, _ success: Bool, _ error: Error?) -> ()) {
        manager.adapter = AccessTokenAdapter(accessToken: AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as! String)
        manager.request(Urls.URL_RAFFLE).validate().responseJSON { (response) in
            debugPrint(response)
            
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                    completionHandler(nil, 0, false, response.error!)
                }
            }
            
            guard response.result.isSuccess else {
                print(response.result.isFailure.description)
                completionHandler(nil, 0, false, response.error!)
                return
            }
            
            //to get JSON return value
            guard let responseJSON = response.result.value as? [String: Any],
                let dataJSON = responseJSON["data"] as? [String: Any] else {
                    print("Invalid raffle information received from the service")
                    completionHandler(nil, 0, false, nil)
                    return
            }
            
            debugPrint(dataJSON)
            var rafflesArray = [Raffle]()
            
            guard let count = dataJSON["count"] as? Int else {
                completionHandler(nil, 0, true, nil)
                return
            }
            
            guard let list = dataJSON["list"] as? [[String : Any]] else {
                print("Couldn't handle list of raffles")
                return
            }
            
            for raffleDictionary in list {
                if let raffle = Raffle.parseToRaffle(dictionary: raffleDictionary) {
                    rafflesArray.append(raffle)
                }
            }
            
            completionHandler(rafflesArray, count, true, nil)
        }
    }
}
