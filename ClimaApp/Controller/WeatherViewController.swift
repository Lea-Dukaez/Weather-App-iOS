//
//  ViewController.swift
//  ClimaApp
//
//  Created by Léa on 07/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherBrain = WeatherBrain()
    let locationManager = CLLocationManager()
    var delegate: CLLocationManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        // show a pop up on screen to ask the user for authorization
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherBrain.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}


// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherBrain.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}


// MARK: - WeatherBrainDelegate

extension WeatherViewController: WeatherBrainDelegate {
    func didUpdateWeather(_ weatherBrain: WeatherBrain, weather: WeatherModel) {
        cityLabel.text = weather.cityName
        weatherIcon.image = UIImage(systemName: weather.conditionName)
        tempLabel.text = weather.temperatureString
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherBrain.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}


