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
    
    func getRaffles(completHandler: @escaping (Bool) -> ()) {
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
                    //completion([false])
                }
            }
            
            guard response.result.isSuccess else {
                print(response.result.isFailure.description)
                return
            }
            
            //to get JSON return value
            debugPrint(response.result.value as? [String: Any] ?? ["nothing" : false])
            guard let responseJSON = response.result.value as? [String: Any],
                let dataJSON = responseJSON["data"] as? [String: Any] else {
                    print("Invalid raffle information received from the service")
                    return
            }
            
            debugPrint(dataJSON)
            
            completHandler(true)
        }
    }
}
