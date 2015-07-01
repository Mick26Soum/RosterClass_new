//
//  CustomCell.swift
//  RosterClass_Table_Scratch
//
//  Created by Mick Soumphonphakdy on 6/30/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var firstNamelabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var customImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
