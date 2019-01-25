//
//  WeatherDataModel.swift
//  SkinCareLab
//
//  Created by Bruno Magalhães on 23/01/19.
//  Copyright © 2019 Cybernetic Company of Milky Way. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var country : String = ""
    var weatherIconName : String = ""
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300, 301...500, 772...780, 782...799, 900...903, 905...1000 :
            return "storm"
            
        case 501...600 :
            return "cloud"
            
        case 601...700, 903 :
            return "snowy"
            
        case 701...771 :
            return "fog"
            
        case 781 :
            return "tornado"
            
        case 800, 904 :
            return "sun"
            
        case 801...804 :
            return "white-cloud"
            
        default :
            return  "robot"
        }
    }
}
