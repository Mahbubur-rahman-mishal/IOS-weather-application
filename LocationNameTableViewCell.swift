//
//  LocationNameTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 9/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class LocationNameTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
