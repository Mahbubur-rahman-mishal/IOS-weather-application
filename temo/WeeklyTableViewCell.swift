//
//  WeeklyTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 19/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class WeeklyTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weeklyImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
