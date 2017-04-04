//
//  DateTableViewCell.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
	@IBOutlet weak var timeLbl: UILabel!
	@IBOutlet weak var eventLbl: UILabel!
	@IBOutlet weak var meetLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
