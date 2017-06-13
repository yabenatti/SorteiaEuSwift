//
//  PersonTableViewCell.swift
//  SorteiaEuSwift
//
//  Created by Yasmin Benatti on 13/06/17.
//  Copyright © 2017 Yasmin Benatti. All rights reserved.
//

import UIKit

let personTableViewCellIdentifier : String! = "personTableViewCellIdentifier"

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
