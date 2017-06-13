//
//  AboutViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Title
        self.title = "Sorteia.eu"
        
        //Logout
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton(_:)))
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

    @IBAction func didTapGitHubButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://github.com/yabenatti/SorteiaEuSwift")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapMobileView(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://yasminbenatti.org/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapApiView(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://github.com/flavioheleno")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapSorteiaEuLabel(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://sorteia.eu/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
        AppUtils.clearUserDefault()
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
    
}
