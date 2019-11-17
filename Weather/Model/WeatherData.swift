//
//  WeatherData.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-16.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
//Decodable protocol
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}
