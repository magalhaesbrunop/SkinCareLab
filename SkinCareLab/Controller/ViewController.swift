//
//  ViewController.swift
//  SkinCareLab
//
//  Created by Bruno Magalhães on 16/01/19.
//  Copyright © 2019 Cybernetic Company of Milky Way. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants - Open Weather's API and key
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "93a68d9442f5cc05cb300dd6a4e6b688"

    //Instances variables declared Location Manager
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //Outlets
    @IBOutlet weak var analizeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var screenMessageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design background Table View and the Button
        backgroundImage.layer.cornerRadius = 20
        analizeButton.layer.cornerRadius = 10
        analizeButton.layer.borderWidth = 3
        analizeButton.layer.borderColor = UIColor.black.cgColor
        
        //Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func getWeatherData(url : String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {(response) in

            if response.result.isSuccess {
                print("Success! Got the weather data")

                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                print(weatherJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)

            let params : [String : String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    func updateUIWithWeatherData() {
        
        let cityData = weatherDataModel.city
        let countryData = weatherDataModel.country
        let temperatureData = weatherDataModel.temperature
        let iconData = weatherDataModel.weatherIconName
        
        cityLabel.text = cityData + " - " + countryData
        temperatureLabel.text = "\(String(temperatureData))º"
        weatherIcon.image = UIImage(named: iconData)
        
        if temperatureData >= 30 {
            screenMessageLabel.text = "Fritando Miólos!"
        } else if(temperatureData >= 20 && temperatureData <= 29) {
            screenMessageLabel.text = "Dia tá quente hoje, né?"
        } else if(temperatureData >= 10 && temperatureData <= 19) {
            screenMessageLabel.text = "Hoje está sendo um dia agradável!"
        } else if(temperatureData >= 0 && temperatureData <= 9) {
            screenMessageLabel.text = "É necessário roupas e abraços quentes!"
        }
    }

    func updateWeatherData(json : JSON) {
        
//        var countriesImperialMetrics = {
//            us = "US"
//            gb = "UK"
//            mm = "MM"
//            lr = "LR"
//
//        }
        
        if let temResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(temResult - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.country = json["sys"]["country"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
           
            updateUIWithWeatherData()
        } else {
            temperatureLabel.text = "Weather Unavailable"
        }
    }

    @IBAction func analizeButton(_ sender: Any) {
        
        
    }
    
}

