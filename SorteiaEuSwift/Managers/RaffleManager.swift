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
    
    func getRaffles(completionHandler: @escaping (_ raffles: [Raffle]?, _ count: Int, _ success: Bool, _ error: Error?) -> ()) {
        manager.adapter = AccessTokenAdapter(accessToken: AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as! String)
        manager.request(Urls.URL_RAFFLE).validate().responseJSON { (response) in
            debugPrint(response)
            debugPrint(response.result)
            
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
            debugPrint(response.result.value as? [String: Any] ?? ["nothing" : false])
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
