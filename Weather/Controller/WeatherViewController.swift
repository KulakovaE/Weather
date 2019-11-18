//
//  ViewController.swift
//  Weather
//
//  Created by Darko Kulakov on 2019-11-15.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var currentLocationBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(scheduleTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
        changeBackground()
        
        locationManager.delegate = self//befor requestLocation to not crash your app
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @objc func scheduleTimer() {
        timer = Timer(fireAt: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 6..<24 ~= Date().hour ? 24 : 6), matchingPolicy: .nextTime)!, interval: 0, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: false)
        print(timer.fireDate)
        RunLoop.main.add(timer, forMode: .common)
        print("new Background chenge scheduled at :", timer.fireDate.description(with: .current))
    }
    
    @objc func changeBackground() {
        let hour = Date().hour
        switch hour {
        case 6...17:
            return backgroundImageView.image = UIImage(named: "Sun")
        case 18...24:
            return backgroundImageView.image = UIImage(named: "Blood")
        default:
            backgroundImageView.image = UIImage(named: "Moon")
            conditionImageView.tintColor = .white
            currentLocationBtn.tintColor = .white
            searchBtn.tintColor = .white
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - Date

extension Date {
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
}
