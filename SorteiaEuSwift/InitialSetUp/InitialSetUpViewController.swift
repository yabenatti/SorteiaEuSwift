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

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let apiToken = AppUtils.retrieveFromUserDefaultWithKey(key: Constants.kApiToken);
        if(apiToken == nil) {
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.present(vc, animated: true, completion: nil)
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
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
