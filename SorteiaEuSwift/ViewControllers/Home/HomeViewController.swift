//
//  HomeViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    var raffleArray = [Raffle]()
    var count : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title
        self.navigationItem.title = "Home"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        //Right Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.didTapRightBarButton(_:)))
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RaffleTableViewCell.classForCoder(), forCellReuseIdentifier: raffleTableViewCellIdentifier)
        self.tableView.register(UINib(nibName: "RaffleTableViewCell", bundle: nil), forCellReuseIdentifier: raffleTableViewCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.emptyStateView.isHidden = true
        self.emptyStateView.messageLabel.text = "Coming Soon!"
        
        self.getRaffles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - Helpers
    
    /*func openAnotherApp() {
        if let url = URL(string: "yasminChat://") {
            if UIApplication.shared.canOpenURL(url) {
                print("Can open")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Something is wrong")
            }
        }
    }*/
    
    func getRaffles() {
        RaffleManager.shared.getRaffles { (rafflesArray, count, success, error) in
            if success {
                print("Success")
                if let array = rafflesArray {
                    self.raffleArray = array;
                    self.count = count;
                    
                    self.tableView.reloadData()
                }
            } else {
                print("Failure")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK : - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.raffleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: raffleTableViewCellIdentifier, for: indexPath) as! RaffleTableViewCell
        
        let raffle : Raffle = self.raffleArray[indexPath.row];
        cell.raffleNameLabel.text = raffle.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 24))
        headerView.titleLabel.text = "RAFFLES"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sb = UIStoryboard(name: "Creation", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RaffleDetailVC") as! RaffleDetailViewController
        vc.isCreatingRaffle = false
        vc.raffle = self.raffleArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK : - IBActions
    
    @IBAction func didTapRightBarButton(_ sender: Any) {
        self.navigationController?.tabBarController?.selectedIndex = 1;
    }
    
    @IBAction func didChangeSegmentedControl(_ sender: Any) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 1:
            self.emptyStateView.isHidden = false
        default:
            self.emptyStateView.isHidden = true
        }
    }
}
