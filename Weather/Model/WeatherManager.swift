//
//  WeatherManager.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-15.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=19054d0481c81eb6fbef7e03a22bd681&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    //Create the Networking, fetch the weatherData
    func performRequest(with urlString: String) {
        //Step 1: Create a URL
        if let url = URL(string: urlString) {
            //Step 2: Create URLSession
            let session = URLSession(configuration: .default)
            //Step 3: Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //Step 4: Start the task
            task.resume()
        }
    }
    //Pasing data from a JSON format
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            //print(weather.temperatureString)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
