//
//  AppUtils.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class AppUtils: NSObject {

    class func saveToUserDefault(objectToSave:Any?, key:String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(_:objectToSave, forKey:key)
        userDefaults.synchronize()
    }
    
    class func retrieveFromUserDefaultWithKey(key: String) -> Any? {
        return UserDefaults.standard.object(forKey:key);
    }
    
    class func clearUserDefault() {
        AppUtils.saveToUserDefault(objectToSave: nil, key: Constants.kApiToken)
    }
}
