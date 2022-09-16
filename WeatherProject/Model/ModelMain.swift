//
//  ModelMain.swift
//  WeatherProject
//
//  Created by Schoo Wer on 12/9/2565 BE.
//

import Foundation
class ModelMain {
    var id: Int?
    var name: String?
    var weather: [Weather] = []
    var temp: Double?
    var cod: Int?
    var tempCelsius: Double?
    var tempFahrenheit: Double?
    var humidity: Int?
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        cod = dictionary["cod"] as? Int
        if let mainDict = dictionary["main"] as? [String: Any] {
            self.humidity = mainDict["humidity"] as? Int
            self.temp = mainDict["temp"] as? Double
            self.tempCelsius = self.temp! - 273.15
            self.tempFahrenheit = 9/5 * (self.temp! - 273) + 32
        }
        if let weatherArray = dictionary["weather"] as? [[String : Any]] {
            weather = weatherArray.map { Weather(dictionary: $0) }
        }
    }
}
