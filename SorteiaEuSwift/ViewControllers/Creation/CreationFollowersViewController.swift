//
//  CreationFollowersViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class CreationFollowersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Followers Raffle"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "raffleDetailSegue" {
            let vc = segue.destination as! RaffleDetailViewController
            vc.isCreatingRaffle = true
        }
    }
    
    // MARK: - IBActions

    @IBAction func didTapDrawButton(_ sender: Any) {
        self.performSegue(withIdentifier: "raffleDetailSegue", sender: nil)
    }
    
    @IBAction func didTapOutsideTheView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
