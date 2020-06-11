//
//  WeatherData.swift
//  ClimaApp
//
//  Created by Léa on 09/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation

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
}
