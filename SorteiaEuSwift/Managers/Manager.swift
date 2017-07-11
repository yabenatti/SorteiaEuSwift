//
//  Manager.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 10/07/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if (urlRequest.url?.absoluteString.hasPrefix(Urls.URL_BASE))! {
            urlRequest.setValue("Token " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}
