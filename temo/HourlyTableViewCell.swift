//
//  HourlyTableViewCell.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 19/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit
import Alamofire

class HourlyTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var HourlyCollectionView: UICollectionView!
    var hourlyWeatherDatas : Hourly?
    var lat = 0.0, lon = 0.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        HourlyCollectionView.dataSource = self
        HourlyCollectionView.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
        HourlyCollectionView.register(nib , forCellWithReuseIdentifier: "CollectionViewCell")
        getWeatherData(lat: lat, lon: lon)
        //print(hourlyWeatherData?.summary)
        // Initialization code
//        if hourlyWeatherData != nil{
//            HourlyCollectionView.reloadData()
//        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherDatas?.data.count ?? 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = HourlyCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let hourly = hourlyWeatherDatas?.data[indexPath.row] {
            let temp = ((hourly.temperature - 32) * (5/9))
            let timeFormat = DateFormatter()
            timeFormat.timeStyle = .short
            timeFormat.dateFormat = "HH:00"
            let time = Date(timeIntervalSince1970: TimeInterval(hourly.time))
            
            collectionCell.Temperature.text = "\(String(Int(temp)))°C"
            print("\(String(Int(temp)))°C")
//            collectionCell.HourlyTempImage.image = getIcon(icon: hourly.icon)
            collectionCell.hourLabel.text = "\(timeFormat.string(from: time))"
        }
        
        if hourlyWeatherDatas != nil {
            print("got data")
        }else {
            print("no data")
        }
        
        return collectionCell
    }
    
    func getWeatherData(lat : Double, lon : Double) {
        let url = "https://api.darksky.net/forecast/ed7e08cdf6c2bcd62440207c1a9b34e1/\(lat),\(lon)"
        Alamofire.request(url, method: .get).responseData { response in
            if response.result.isFailure, let error = response.result.error {
                print(error)
            }
            
            if response.result.isSuccess, let value = response.result.value{
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: value)
                    self.hourlyWeatherDatas = weather.hourly
                    self.HourlyCollectionView.reloadData()
                } catch {
                    print(error)
                }
            }
            
        }
        
    }
    
    

}
