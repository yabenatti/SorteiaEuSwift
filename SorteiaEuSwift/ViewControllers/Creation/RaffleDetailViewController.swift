//
//  RaffleDetailViewController.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

class RaffleDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var raffleNameLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var isCreatingRaffle : Bool? = false
    var drawsArray = [Draw]()
    var raffle : Raffle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Title
        self.navigationItem.title = "Raffle Detail"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PersonTableViewCell.classForCoder(), forCellReuseIdentifier: personTableViewCellIdentifier)
        self.tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: personTableViewCellIdentifier)
        
        self.getSpecificRaffle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(false, animated: false)
        
        if let booleanValue = self.isCreatingRaffle, booleanValue {
            // Executes when booleanValue is not nil and true
            // A new constant "booleanValue: Bool" is defined and set
            print("bound booleanValue: '\(booleanValue)'")
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.didTapDoneButton(_:)))
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helpers
    
    func getSpecificRaffle() {
        guard let raffle = self.raffle else {
            print("No raffle detail")
            return
        }
        
        RaffleManager.shared.getSpecificRaffle(raffleID: raffle.raffleId) { (raffle, success, error) in
            if success {
                if let raffle = raffle {
                    //Fill card
                    self.raffleNameLabel.text = raffle.name
                    if raffle.createdAt > 0 {
                        // convert Int to Double
                        let timeInterval = Double(raffle.createdAt)
                        let date = Date(timeIntervalSince1970: timeInterval)
                        
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
                        
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        self.createdOnLabel.text = dateString;
                    }
                    
                    //Retrieve draw
                    self.getDraws(raffle: raffle)
                }
            } else {
                print("Error Specific Raffle :/")
            }
        }
    }
    
    func getDraws(raffle: Raffle) {
        RaffleManager.shared.getDrawFromRaffle(raffleID: raffle.raffleId) { (draw, count, success, error) in
            if success {
                if let receivedDraw = draw {
                    self.drawsArray = receivedDraw
                    self.tableView.reloadData()
                }
            } else {
                print("Error Draws :/")
            }
        }
    }
    
    func parseDuration(timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        
        var interval:Double = 0
        
        let parts = timeString.components(separatedBy:":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        return interval
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
        return self.drawsArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: personTableViewCellIdentifier, for: indexPath) as! PersonTableViewCell
        
        let draw = self.drawsArray[indexPath.row]
        cell.personNameLabel.text = draw.person.name
        cell.personImageView.image = UIImage(named: "ic_face")
        
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
        headerView.titleLabel.text = "WINNERS"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "Disquilify") { action, index in
            print("disquilify button tapped")
        }
        more.backgroundColor = .lightGray
        
        return [more]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let draw = self.drawsArray[indexPath.row]

        if draw.disquilified {
            return false
        }
        
        return true
    }
    
    // MARK : - IBActions
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }

}
