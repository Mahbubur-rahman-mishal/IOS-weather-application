//
//  CurrentWeatherTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 19/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var currentTemperature: UILabel!
    
    @IBOutlet weak var currentTemparatureImage: UIImageView!
    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var currentDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
