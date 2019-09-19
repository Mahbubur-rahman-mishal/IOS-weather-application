//
//  HourlyTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 19/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var HourlyCollectionView: UICollectionView!
        var hourlyWeatherData : Hourly?
    override func awakeFromNib() {
        super.awakeFromNib()
        HourlyCollectionView.dataSource = self
//        HourlyCollectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
        HourlyCollectionView.register(nib , forCellWithReuseIdentifier: "CollectionViewCell")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData?.data.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = HourlyCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let hourly = hourlyWeatherData?.data[indexPath.row] {
            let temp = ((hourly.temperature - 32) * (5/9))
            let timeFormat = DateFormatter()
            timeFormat.timeStyle = .short
            timeFormat.dateFormat = "HH:00"
            let time = Date(timeIntervalSince1970: TimeInterval(hourly.time))
            
            collectionCell.Temperature.text = "\(String(Int(temp)))°C"
//            collectionCell.HourlyTempImage.image = getIcon(icon: hourly.icon)
            collectionCell.hourLabel.text = "\(timeFormat.string(from: time))"
        }
        
        return collectionCell
    }
}

