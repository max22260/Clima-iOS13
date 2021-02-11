//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

import  CoreNFC

class WeatherViewController: UIViewController  {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
        
    }
    
    @IBAction func getLocationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
    }
}

    

//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
    //dismiss keyboard after presed done or return  !
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.endEditing(true)
        return true
    }
    
    
    //clear text field after pressed done !!
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            
            weatherManager.fetchWeather(cityName: city)
            cityLabel.text = city.capitalized
        }
        
        searchTextField.text = ""
        
        searchTextField.placeholder = "Search"
        
        
    }
    
    // should write somthing s
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            return true
            
        }else{
            
            textField.placeholder = "Type somthing "
            
            return false
        }
        
    }
    
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController : WeatherManagerDelegate {
    
    
    func didUpdateWeather(_ weatherManger: WeatherManager , weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.ConditionName)
            self.cityLabel.text = weather.cityName
            
        }
    }

    
    func didFialWithError(_ error: Error) {
        
        print(error)
        
    }
}


//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location  = locations.last {
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat , longitude : lon)
            
        }
    
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
    }
    
    
}

