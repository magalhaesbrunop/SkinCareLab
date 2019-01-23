//
//  ViewController.swift
//  SkinCareLab
//
//  Created by Bruno Magalhães on 16/01/19.
//  Copyright © 2019 Cybernetic Company of Milky Way. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants - Open Weather's API and key
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"

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
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations[locations.count - 1]
        if userLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("latitude = \(userLocation.coordinate.latitude), longitude = \(userLocation.coordinate.longitude)")
            
            let latitude = String(userLocation.coordinate.latitude)
            let longitude = String(userLocation.coordinate.longitude)
            
            let params : [String : String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    func updateUIWithWeatherData() {
        //cityLabel.text = weatherDataModel.city
    }

    @IBAction func analizeButton(_ sender: Any) {
        
        
    }
    
}

