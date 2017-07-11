//
//  LoginViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    
    @IBAction func didTapOutsideTheView(_ sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        // Alamofire 4
        guard let email = self.emailTextField.text, !email.isEmpty else {
            print("No name")
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            print("No password")
            return
        }
        
        let parameters: Parameters = ["email": email, "password" : password]
        
        Alamofire.request(Urls.URL_LOGIN, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                        //completion([false])
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
                    self.dismiss(animated: true, completion: nil)
                }
                
                //completion([true])
        }
    }

}
