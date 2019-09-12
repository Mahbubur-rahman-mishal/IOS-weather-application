//
//  Place.swift
//  temo
//
//  Created by Mahbubur Rahman Mishal on 11/9/19.
//  Copyright © 2019 Mahbubur Rahman Mishal. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - WeatherElement
class Place: Object, Codable {
    @objc dynamic var name: String
    @objc dynamic var lat, lon: Double
}

//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)


