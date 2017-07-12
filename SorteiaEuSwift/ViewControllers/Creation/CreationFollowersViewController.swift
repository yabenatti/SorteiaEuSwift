//
//  CreationFollowersViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class CreationFollowersViewController: UIViewController {

    @IBOutlet weak var numberOfWinnersTextField: UITextField!
    @IBOutlet weak var raffleNameTextField: UITextField!
    
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
            if let raffle = sender as? Raffle {
                vc.raffle = raffle
            }
        }
    }
    
    // MARK: - IBActions

    @IBAction func didTapDrawButton(_ sender: Any) {
        guard let name = self.raffleNameTextField.text, !name.isEmpty else {
            print("No name")
            return
        }
        guard let numberOfWinners = self.numberOfWinnersTextField.text, !numberOfWinners.isEmpty else {
            print("No number of winners")
            return
        }
        
        RaffleManager.shared.createRaffle(type: Constants.kTypeFollower, name: name) { (raffle, success, error) in
            if success {
                self.performSegue(withIdentifier: "raffleDetailSegue", sender: raffle)

            } else {
                print("Failure creating raffle")
            }
        }
    }
    
    @IBAction func didTapOutsideTheView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
