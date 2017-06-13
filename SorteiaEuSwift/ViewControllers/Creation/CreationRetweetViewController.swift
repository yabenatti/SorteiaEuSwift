//
//  CreationRetweetViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class CreationRetweetViewController: UIViewController {

    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Retweet Raffle"
        
        self.emptyStateView.messageLabel.text = "Coming Soon! :)"
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
