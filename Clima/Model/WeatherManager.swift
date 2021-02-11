//
//  File.swift
//  Clima
//
//  Created by Nagy on 03/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation




protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManger: WeatherManager , weather: WeatherModel)
    func didFialWithError(_ error: Error)
}


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7ffee1fb5831f5887173fe0c141a9de2&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString)
        
    }
    
    func  fetchWeather(latitude: Double , longitude : Double){
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        
        performRequest(with: urlString)
        
    }
    
    
    func performRequest(with urlString : String) -> Void {
        
        // 1 - create Url
        if let url = URL(string: urlString){
            
            // 2 - create session
            let session = URLSession(configuration: .default)
            // 3 - create task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                
                if error != nil {
                    delegate?.didFialWithError(error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = parseJSON(safeData){
                        
                        delegate?.didUpdateWeather( self, weather: weather)
                    }
                }
            }
            // 4 - start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do{
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            
            
            return weatherModel
            
            
        }catch{
            
            self.delegate?.didFialWithError(error)
            
            return nil
        }
    }
    
}





