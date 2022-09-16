//
//  ForcastList.swift
//  WeatherProject
//
//  Created by Schoo Wer on 15/9/2565 BE.
//

import Foundation
class ForcastList {
    var temp: Double?
    var humidity: Int?
    var tempCelsius: Double?
    var tempFahrenheit: Double?
    
    init(dictionary: [String: Any]) {
        humidity = dictionary["humidity"] as? Int
        if let temp = dictionary["temp"] as? Double {
            self.temp = temp
            self.tempCelsius = temp - 273.15
            self.tempFahrenheit = (9/5 * (temp - 273) + 32)
        }
    }
}
