//
//  NetworkManager.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 2017-06-15.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
}

/*

class NetworkManager: NSObject {

    class var sharedInstance: NetworkManager {
        struct Static {
            static let instance: NetworkManager = NetworkManager()
        }
        return Static.instance
    }
    
    
//    func fetchProfileInfoWithId(_ userId:String, completion:(_ isSuccess:Bool, _ message:String, _ error:NSError) -> Void) {
//        let url = "http://www.delivve.com.br/api/v1/users/3?uid=3"
//        conectWithParameters(nil, path: url, requestType: "GET") { (response, isSuccess, message, error) in
//            if(isSuccess) {
//                do {
//                    if let responseDictionary = response!["profile"] as? Dictionary<String, AnyObject> {
//                        print(responseDictionary)
//                        if let name = responseDictionary["email"] as? String {
//                            print(name)
//                        }
//                    }
//                } catch {
//                    print("error serializing JSON: \(error)")
//                }
//            }
//        }
//    }
//
//    func loginWithAPI(_ parameters:Dictionary<String, AnyObject>?, completion:(_ isSuccess:Bool, _ message:String, _ error:NSError) -> Void) {
//        let url = "http://www.delivve.com.br/api/v1/ads/105/interests"
//        conectWithParameters(parameters, path: url, requestType: "POST") { (response, isSuccess, message, error) in
//            if(isSuccess) {
//                
//            }
//        }
//    }

    /*!
     * @discussion Verifica se o usuário está conectado a internet
     */
    func checkReachabilityWithCompletion(_ completion: @escaping (_ isReachable: Bool, _ erro:NSError?) -> Void) {
        
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        net?.listener = {status in
            
            if  net?.isReachable ?? false {
                completion(true,nil)
            }
            else {
                print("no connection")
                let info = NSMutableDictionary ()
                let messageDict = NSMutableDictionary()
                
                messageDict.setValue("noConnection", forKey: "message")
                info.setValue("not.reachable", forKey: NSLocalizedDescriptionKey)
                info.setValue(messageDict, forKey: "JSONResponseSerializerWithDataKey")
                
                let error = NSError.init(domain: "not.reachable", code: 0, userInfo: info as? [AnyHashable: Any])
                completion(false, error)
            }
        }
    }
    
    /*
    func loginWithAPI(_ parameters:Dictionary<String, AnyObject>?, completion:(_ isSuccess:Bool, _ message:String, _ error:NSError) -> Void) {
        let url = Urls.URL_LOGIN
        conectWithParameters(parameters, path: url!, requestType: "POST") { (response, isSuccess, message, error) in
            if(isSuccess) {
                print(response!)
            } else {
                print(error!)
            }
        }
    }
 */


    /*!
     * @discussion Método que configura uma requisição à API que não possuem upload de arquivos.
     * @param parameters dicionário com os parametros da requisição
     * @param path URL da requisição
     * @param type tipo de requisição
     * @param completion bloco passado para ações com a resposta
     * @return void
     */
    func conectWithParameters(_ parameters: Dictionary<String, AnyObject>?, path:URLConvertible, requestType: NSString, completion: @escaping (_ response: AnyObject?, _ isSuccess: Bool, _ message: NSString?, _ error:NSError?) -> Void) {
        
        checkReachabilityWithCompletion { (isReachable, erro) in
            if(isReachable) {
                self.callHttpWithParameters(parameters, path: path, requestType: requestType, completion: { (response, isSuccess, message, error) in
                    if(isSuccess) {
                        print("Funcionou Connect With Parameters")
                        
                        completion(response, true, nil, nil)
                    } else {
                        completion(nil, false, message, error)
                    }
                })
            } else {
                completion(nil, false, "Verifique a sua conexão com a internet", nil)
            }
        }
    }

    /*!
     * @discussion Metodo que configura um erro de timeout do servidor
     * @return NSError com todas as informações do erro de timeout
     */

    func timeoutError() -> NSError {
        let info = NSMutableDictionary()
        let messageDict = NSMutableDictionary()
        messageDict.setValue("Tempo da requisição foi esgotado.", forKey: "message")
        info.setValue("timeout", forKey: NSLocalizedDescriptionKey)
        info.setValue(messageDict, forKey: "JSONResponseSerializerWithDataKey")
        let error = NSError.init(domain: "timeout", code: 0, userInfo: info as? [AnyHashable: Any])
        
        return error
    }

    /*!
     * @discussion Executa a chamada à API sem upload de arquivos
     * @param parameters dicionário com os parametros da requisição
     * @param path URL da requisição
     * @param type tipo de requisição
     * @param completion bloco passado para ações com a resposta
     * @return void
     */
    func callHttpWithParameters(_ parameters: Dictionary<String, AnyObject>?, path:URLConvertible, requestType: NSString, completion: @escaping (_ response: AnyObject?, _ isSuccess: Bool, _ message: NSString?, _ error:NSError?) -> Void) {
        
        let headers = [
            "Authorization": AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken) as! String
        ]
        
        print(headers);
        
        if(requestType.isEqual(to: "GET")) {
            Alamofire.request(path, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
                
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    
                    if let JSON = response.result.value {
                        let status = JSON as! Dictionary<String, AnyObject>
                        if  status["status"] as! NSNumber == 0 {
                            completion(status as AnyObject, true, nil, nil)
                        } else {
                            completion(nil, false,"message", nil)
                        }
                    }
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    if (!error.localizedDescription.isEmpty) {
                        completion(nil, false, error.localizedDescription as NSString, error as NSError)
                    }
                    else {
//                        if (error.des != "") {
//                            if error.code == NSURLErrorTimedOut {
//                                completion(response: nil, isSuccess: false, message: "Tempo da requisição foi esgotado.", error: self.timeoutError())
//                            } else {
//                                completion(response: nil, isSuccess: false, message: "Não foi possível se conectar ao servidor, por favor tente novamente", error: error)
//                                
//                            }
//                            
//                        } else {
//                            completion(response: nil, isSuccess: false, message: "Houve uma falha ao se conectar com o servidor, por favor tente novamente", error: nil)
//                        }
                    }
                }
            }
            
        }
            
            
        /*else if (requestType.isEqual(to: "POST")){
            self.manager!.request(.POST, path, parameters: parameters, headers:headers)
                .validate(contentType: ["application/json"])
                .responseJSON {
                    response in  switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        if let JSON = response.result.value {
                            let status = JSON["status"]
                            if  status as! NSNumber == 0 {
                                completion(response: JSON["data"], isSuccess: true, message: nil, error: nil)
                            } else {
                                completion(response: JSON["data"], isSuccess: false, message: "message", error: nil)
                            }
                        }
                        //
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        if (error.userInfo["NSLocalizedDescription"] != nil) {
                            completion(response: nil, isSuccess: false, message: error.userInfo["NSLocalizedDescription"] as! String, error: error)
                        }
                        else {
                            if (error.description != "") {
                                if error.code == NSURLErrorTimedOut {
                                    completion(response: nil, isSuccess: false, message: "Tempo da requisição foi esgotado.", error: self.timeoutError())
                                } else {
                                    completion(response: nil, isSuccess: false, message: "Não foi possível se conectar ao servidor, por favor tente novamente", error: error)
                                    
                                }
                                
                            } else {
                                completion(response: nil, isSuccess: false, message: "Houve uma falha ao se conectar com o servidor, por favor tente novamente", error: nil)
                            }
                        }
                    }
                    
            }
            
        }
            
        else if (requestType.isEqual(to: "DELETE")){
            self.manager!.request(.DELETE, path, parameters: nil)
                .responseJSON {
                    response in  switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        if let JSON = response.result.value {
                            let status = JSON["status"]
                            if  status as! NSNumber == 0 {
                                completion(response: JSON["data"], isSuccess: true, message: nil, error: nil)
                            } else {
                                completion(response: JSON["data"], isSuccess: false, message: "message", error: nil)
                            }
                        }
                    //
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        if (error.userInfo["NSLocalizedDescription"] != nil) {
                            completion(response: nil, isSuccess: false, message: error.userInfo["NSLocalizedDescription"] as! String, error: error)
                        }
                        else {
                            if (error.description != "") {
                                if error.code == NSURLErrorTimedOut {
                                    completion(response: nil, isSuccess: false, message: "Tempo da requisição foi esgotado.", error: self.timeoutError())
                                } else {
                                    completion(response: nil, isSuccess: false, message: "Não foi possível se conectar ao servidor, por favor tente novamente", error: error)
                                    
                                }
                            } else {
                                completion(response: nil, isSuccess: false, message: "Houve uma falha ao se conectar com o servidor, por favor tente novamente", error: nil)
                            }
                        }                    }
                    
            }
            
        }   else if (requestType.isEqual(to: "PATCH")){
            self.manager!.request(.PATCH, path, parameters: nil)
                .responseJSON {
                    response in  switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        completion(response: JSON["data"], isSuccess: true, message: nil, error: nil)
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        completion(response: nil, isSuccess: false, message: nil, error: error)
                        
                    }
                    
            }
            
        }*/
        
    }

}
*/
