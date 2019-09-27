//
//  GraphViewController.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 27/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    var weatherGraphData : Weather?
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lineChartViewrain: LineChartView!
    @IBOutlet weak var SummaryLabel: UILabel!
    @IBOutlet weak var AlertLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartValues()
        self.lineChartView.layer.cornerRadius = 10;       self.lineChartView.clipsToBounds = true;
        SummaryLabel.text = weatherGraphData?.currently.summary
        
        if (weatherGraphData?.currently.uvIndex)! > 2 {
            AlertLabel.text = "Wear sunglasses - UV Index:\((weatherGraphData?.currently.uvIndex)!)"
        } else if (weatherGraphData?.currently.uvIndex)! > 3 {
            AlertLabel.text = "Stay in shade near midday when the Sun is strongest - UV Index:\((weatherGraphData?.currently.uvIndex)!)"
        } else if (weatherGraphData?.currently.uvIndex)! > 5 {
            AlertLabel.text = "Reduce time in the Sun between 10 a.m. and 4 p.m - UV Index:\((weatherGraphData?.currently.uvIndex)!)"
        } else {
            AlertLabel.text = "No Alert"
        }
                
        // Do any additional setup after loading the view.
    }
    
    func setChartValues(){
//        var hour = 00.00
//        for data in (weatherGraphData?.hourly.data)! {
//            let timeFormat = DateFormatter()
//            timeFormat.timeStyle = .short
//            timeFormat.dateFormat = "HH:00"
//            let temp = Date(timeIntervalSince1970: TimeInterval(data.time))
//            hour = Double(timeFormat.string(from: temp))!
//            return ChartDataEntry(x: hour, y: data.)
        let values = (0..<9).map { (i) -> ChartDataEntry in
            let timeFormat = DateFormatter()
            timeFormat.timeStyle = .short
            timeFormat.dateFormat = "HH:00"
            let tempo = weatherGraphData?.hourly.data[i].time
            let time = Date(timeIntervalSince1970: TimeInterval((tempo)!))
            let hour = timeFormat.string(from: time)
            let mainHour = hour.prefix(while: { "0"..."9" ~= $0 })
            let temp = (((weatherGraphData?.hourly.data[i].temperature ?? 00) - 32) * (5/9))
            print(mainHour,temp)
            return ChartDataEntry(x: Double(i+3), y: temp.rounded())
        }
        
        let precip = (0..<9).map { (i) -> ChartDataEntry in
            let timeFormat = DateFormatter()
            timeFormat.timeStyle = .short
            timeFormat.dateFormat = "HH:00"
            let tempo = weatherGraphData?.hourly.data[i].time
            let time = Date(timeIntervalSince1970: TimeInterval((tempo)!))
            let hour = timeFormat.string(from: time)
            let mainHour = hour.prefix(while: { "0"..."9" ~= $0 })
            let temp = (weatherGraphData?.hourly.data[i].precipProbability)! * 100
            print(mainHour,temp)
            return ChartDataEntry(x: Double(i+3), y: temp.rounded())
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Temperature Insight")
        let data = LineChartData(dataSet : set1)
        let set2 = LineChartDataSet(entries: precip, label: "Precipitation Probability")
        let data2 = LineChartData(dataSet : set2)
        
        self.lineChartView.data = data
        self.lineChartViewrain.data = data2
        
            
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




