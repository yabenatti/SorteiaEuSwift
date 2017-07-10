//
//  LoginManager.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 2017-06-15.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit
import Alamofire

class LoginManager {
    
    /*func loginWithParameters(parameters: Parameters, completion: @escaping ([Bool]) -> Void) {
        Alamofire.request(Urls.URL_LOGIN, method: .post, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response.result)
                
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                        completion([false])
                    }
                }
                
                //to get JSON return value
                debugPrint(response.result.value as? [String: Any] ?? ["nothing" : false])
                guard let responseJSON = response.result.value as? [String: Any],
                    let dataJSON = responseJSON["data"] as? [String: Any] else {
                        print("Invalid login information received from the service")
                        return
                }
                
                debugPrint(dataJSON)
                
                if let token = dataJSON["token"] as? String {
                    AppUtils.saveToUserDefault(objectToSave: token, key: Constants.kApiToken)
                }
                
                completion([true])
        }
    }*/
    
}
