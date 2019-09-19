//
//  CollectionViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 19/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var HourlyTempImage: UIImageView!
    @IBOutlet weak var Temperature: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


