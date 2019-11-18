//
//  WeatherModel.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-17.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
//Model to hold on our Data
struct WeatherModel {
    let conditionId: Int // stored property, they are storing a pice of Data
    let cityName: String
    let temperature: Double
    
    var temperatureString: String { // computed property, has to be VAR - value will be changed, return output it vill be the value of the property, workout its value.
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String { // computed property, only can be defined with var
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case  500...504:
            return "cloud.sun.rain.fill"
        case  511:
            return "snow.fill"
        case 520...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801:
            return "cloud.sun.fill"
        case 802:
            return "cloud.fill"
        case 803...804:
            return "smoke.fill"
        default:
            return "cloud"
        }
    }
}
