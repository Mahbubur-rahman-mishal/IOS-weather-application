//
//  ExtraTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 27/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class ExtraTableViewCell: UITableViewCell {
    var navigationController: UINavigationController?
    var extra_weather : Weather?
    var delegate : buttontapped?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func GraphButtonDidTap(_ sender: UIButton) {
        delegate?.navigate(weather: extra_weather!)
        
    }
    
}

