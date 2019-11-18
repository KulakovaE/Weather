//
//  WeatherData.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-16.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
