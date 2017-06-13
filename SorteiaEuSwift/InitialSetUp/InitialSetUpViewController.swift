//
//  InitialSetUpViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class InitialSetUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let apiToken = AppUtils.retrieveFromUserDefaultWithKey(key: "API_TOKEN");
        if(apiToken == nil) {
            AppUtils.saveToUserDefault(objectToSave: "ashd28203aish2913b", key: "API_TOKEN")
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.present(vc, animated: true, completion: nil)
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            self.navigationController?.present(vc!, animated: true, completion: nil)
        }
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

}
