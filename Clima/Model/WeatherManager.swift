//
//  File.swift
//  Clima
//
//  Created by Nagy on 03/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation



struct WeatherManager {
    
   let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=7ffee1fb5831f5887173fe0c141a9de2&q=cairo&units=metric"
    
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
    }
    
}
