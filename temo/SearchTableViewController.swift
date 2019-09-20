//
//  SearchViewController.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 9/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var weatherDataForCity = [Weather]()
    let realm = try! Realm()
    var savedPlace: Results<Place> {
        get {
            return realm.objects(Place.self)
        }
    }

    @IBOutlet weak private var tableView: UITableView!
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        if let addViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "addViewController") as? addViewController {
        navigationController?.pushViewController(addViewController, animated: true)
        }
    }
    
    @IBAction func editButtonDidTap(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneButtonDidTap))
        
    }
    
    @objc func doneButtonDidTap(){
        self.tableView.isEditing = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonDidTap))

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "LocationNameTableViewCell", bundle: Bundle.main)
        tableView.register(nib , forCellReuseIdentifier: "LocationNameTableViewCell")
        title = "City Name"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPlace.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//            detailViewController.weatherData = weatherDataForCity[indexPath.row]
            detailViewController.lat = savedPlace[indexPath.row].lat
            detailViewController.lon = savedPlace[indexPath.row].lon
            detailViewController.cityName = savedPlace[indexPath.row].name
            navigationController?.pushViewController(detailViewController, animated: true)
        
            tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationNameTableViewCell", for: indexPath) as! LocationNameTableViewCell

        let lat = savedPlace[indexPath.row].lat
        let lon = savedPlace[indexPath.row].lon
        let url = "https://api.darksky.net/forecast/ed7e08cdf6c2bcd62440207c1a9b34e1/\(lat),\(lon)"
        Alamofire.request(url, method: .get).responseData { response in
            if response.result.isFailure, let error = response.result.error {
                print(error)
            }

            if response.result.isSuccess, let value = response.result.value{
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: value)
                    self.weatherDataForCity.append(weather)
                    let temp = String(Int(5.0 / 9.0 * (Double(weather.currently.temperature) - 32.0)))
                    cell.locationLabel.text = self.savedPlace[indexPath.row].name
                    cell.tempLabel.text = "\(temp)°C"
                    //        cell.tempImage = "Clear.png"
                } catch {
                    print(error)
                }
                

            }

        }
        cell.locationLabel.text = savedPlace[indexPath.row].name
//        cell.tempImage = "Clear.png"
        return cell
    }
    
    



    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let city = savedPlace[indexPath.row]
            try! realm.write {
                realm.delete(city)
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
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

