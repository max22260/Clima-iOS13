//
//  weatherData.swift
//  Clima
//
//  Created by Nagy on 04/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//


struct WeatherData : Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main : Codable {
    
    let temp:Double
}

struct Weather : Codable {
    
    let id: Int
    
}
