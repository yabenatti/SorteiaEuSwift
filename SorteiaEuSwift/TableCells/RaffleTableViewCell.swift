//
//  RaffleTableViewCell.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

let raffleTableViewCellIdentifier : String! = "raffleTableViewCellIdentifier"

class RaffleTableViewCell: UITableViewCell {

    @IBOutlet weak var raffleNameLabel: UILabel!
    @IBOutlet weak var raffleCreationDateLabel: UILabel!
    @IBOutlet weak var raffleUrlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
