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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
            }
            return currentWeatherCell
            
        case 1:
            let hourlyWeatherCell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath) as! HourlyTableViewCell
            hourlyWeatherCell.hourlyWeatherData = weatherData?.hourly
            return hourlyWeatherCell
            
            
        default:
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as! CurrentWeatherTableViewCell
            defaultCell.currentTemperature.text = "Error"
            return defaultCell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var weatherData : Weather?
    var lon = 0.0, lat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getWeatherData(lat: lat, lon: lon)
        let currentNib = UINib(nibName: "CurrentWeatherTableViewCell", bundle: Bundle.main)
        tableView.register(currentNib , forCellReuseIdentifier: "CurrentWeatherTableViewCell")
        let hourlyNib = UINib(nibName: "HourlyTableViewCell", bundle: Bundle.main)
        tableView.register(hourlyNib, forCellReuseIdentifier: "HourlyTableViewCell")
        title = "City Name"
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Current Weather"
        } else if section == 1 {
            return "Hourly Forecast"
        } else if section == 2 {
            return "Weekly Forecast"
        } else {return ""}
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
                } catch {
                    print(error)
                }
            }
            self.tableView.reloadData()
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
