//
//  WeatherModel.swift
//  ClimaApp
//
//  Created by Léa on 10/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let name: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var cityName: String {
        return  name.replacingOccurrences(of: "Arrondissement de", with: "")
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...240:
            return "cloud.bolt"
        case 300...330:
            return "cloud.drizzle"
        case 500...540:
            return "cloud.heavyrain"
        case 600...630:
            return "snow"
        case 700...790:
            return "cloud.fog"
        case 802...805:
            return "cloud"
        case 800:
            return "sun.max"
        default:
            return "cloud.sun"
        }
    }
    
}
