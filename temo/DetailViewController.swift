//
//  DetailViewController.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 18/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//
import Alamofire
import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var weatherData : Weather?
    var lon = 0.0, lat = 0.0
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let currentNib = UINib(nibName: "CurrentWeatherTableViewCell", bundle: Bundle.main)
        tableView.register(currentNib , forCellReuseIdentifier: "CurrentWeatherTableViewCell")
        let hourlyNib = UINib(nibName: "HourlyTableViewCell", bundle: Bundle.main)
        tableView.register(hourlyNib, forCellReuseIdentifier: "HourlyTableViewCell")
        let weeklyNib = UINib(nibName: "WeeklyTableViewCell", bundle: Bundle.main)
        tableView.register(weeklyNib, forCellReuseIdentifier: "WeeklyTableViewCell")
        title = cityName.uppercased()
        
        
        getWeatherData(lat: lat, lon: lon)
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 7
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let currentWeatherCell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as! CurrentWeatherTableViewCell
            if let temp = weatherData?.currently.temperature, let date = weatherData?.currently.time {
                currentWeatherCell.currentTemperature.text = "\(Int(5.0 / 9.0 * ((temp) - 32.0)))°C"
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                let time = Date(timeIntervalSince1970: TimeInterval(date))
                currentWeatherCell.currentDate.text = "\(dateFormatter.string(from: time))"
                currentWeatherCell.currentTemparatureImage.image = setIcon(icon: (weatherData?.currently.icon)!)
            }
            return currentWeatherCell
            
        case 1:
            let hourlyWeatherCell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath) as! HourlyTableViewCell
            hourlyWeatherCell.lat = lat
            hourlyWeatherCell.lon = lon
//            if let check = weatherData?.hourly{
//                hourlyWeatherCell.hourlyWeatherData = check
//                print(check.summary)
//            }
            print(weatherData?.hourly.data.count ?? -100)
            return hourlyWeatherCell
            
        case 2:
            let weeklyWeatherCell = tableView.dequeueReusableCell(withIdentifier: "WeeklyTableViewCell", for: indexPath) as! WeeklyTableViewCell
            let dailyData = weatherData?.daily.data[indexPath.row]
            if let day = dailyData?.time {
                let time = Date(timeIntervalSince1970: TimeInterval(day))
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                let date = dateFormatter.date(from: dateFormatter.string(from: time))
                dateFormatter.dateFormat = "EEEE"
                weeklyWeatherCell.dayLabel.text = "\(dateFormatter.string(from: date!))"
                let maxTemp = dailyData!.apparentTemperatureMax
                let minTemp = dailyData!.apparentTemperatureMin
                weeklyWeatherCell.maxTemperatureLabel.text = "\(Int(5.0 / 9.0 * ((maxTemp) - 32.0)))°C"
                weeklyWeatherCell.minTemperatureLabel.text = "\(Int(5.0 / 9.0 * ((minTemp) - 32.0)))°C"
                weeklyWeatherCell.weeklyImage.image = setIcon(icon: dailyData!.icon)
            }
            return weeklyWeatherCell
            
            
            
        default:
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as! CurrentWeatherTableViewCell
            defaultCell.currentTemperature.text = "Error"
            return defaultCell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section == 1 {
            return "Hourly Forecast"
        } else if section == 2 {
            return "Weekly Forecast"
        } else {return ""}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 95
        case 2:
            return 55
        default:
            return 120
        }
    }
    
    func setIcon(icon: String) -> UIImage {
        switch icon {
        case "cloudy":
            return UIImage(named: "rain-cloud")!
            
        case "clearDay":
            return UIImage(named: "Clear")!
            
        case "rain":
            return UIImage(named: "rain")!
            
        case "snow":
            return UIImage(named: "rain")!
            
        case "clearNight":
            return UIImage(named: "moon-and-stars")!
            
        case "sleet":
            return UIImage(named: "sleet")!
            
        case "wind":
            return UIImage(named: "windy-weather")!
            
        case "fog":
            return UIImage(named: "fog")!
            
        default:
            return UIImage(named: "Clear")!
        }
        
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
                    self.weatherData = weather
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
            
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}

//extension UINavigationBar {
//    func changeFont() {
//        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name:"Poppins-Medium", size: 20)!]
//    }
//}
