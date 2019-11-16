//
//  WeatherManager.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-15.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=19054d0481c81eb6fbef7e03a22bd681&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    //Create the Networking
    func performRequest(urlString: String) {
        //Step 1: Create a URL
        if let url = URL(string: urlString) {
            //Step 2: Create URLSession
            let session = URLSession(configuration: .default)
            //Step 3: Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Step 4: Start the task
            task.resume()
        }
    }
    
    //Pasing data from a JSON format
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
