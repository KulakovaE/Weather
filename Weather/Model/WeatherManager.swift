//
//  WeatherManager.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-15.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=19054d0481c81eb6fbef7e03a22bd681&q=london&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
 
}
