//
//  WeatherBrain.swift
//  ClimaApp
//
//  Created by Léa on 09/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherBrainDelegate {
    func didUpdateWeather(_ weatherBrain: WeatherBrain, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherBrain {
    
    var delegate: WeatherBrainDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    func fetchWeather(cityName: String) {
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY_CLIMA_APP"] {
            let newCityName = cityName.replacingOccurrences(of: " ", with: "+")
            let urlString = "\(weatherURL)&appid=\(apiKey)&q=\(newCityName)"
            performRequest(with: urlString)
        } else {
            print("Please create your API Key for https://api.openweathermap.org and add it as environment variable under 'API_KEY_CLIMA_APP'")
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) { 
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        if let weather = self.parseJSON(safeData) {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
        
            let weather = WeatherModel(conditionId: id, name: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

