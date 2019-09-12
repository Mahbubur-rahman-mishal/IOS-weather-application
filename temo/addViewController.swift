//
//  addViewController.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 11/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class addViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    var searchedAreas = [Place]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
   
    func getPlaceInfo(searchText:String){
        let url = "https://api.apixu.com/v1/search.json?key=181d48a6ecb046cca6d80729190909&q=\(searchText)"
//        print(url)
        Alamofire.request(url, method: .get).responseData { response in
            if response.result.isFailure, let error = response.result.error {
                print(error)
            }

            if response.result.isSuccess, let value = response.result.value{
                do {
                    let place = try JSONDecoder().decode([Place].self, from: value)
                    self.searchedAreas = place
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
                
            }
            
        }
//        tableView.reloadData()
        
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let searchBarText = searchBar.text
//        getPlaceInfo(searchText: searchBarText ?? "")
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let realm = try! Realm()
        let location = searchedAreas[indexPath.row]
        do{
            try realm.write {
                realm.add(location)
                }
        }catch{
            print(error.localizedDescription)
        }
        print("successful")
        navigationController?.popViewController(animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarText = searchText
        getPlaceInfo(searchText: searchBarText )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedAreas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let searchedArea = searchedAreas[indexPath.row]
        cell.textLabel?.text = searchedArea.name
        return cell
        
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
