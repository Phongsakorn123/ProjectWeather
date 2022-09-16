//
//  ForcastWeather.swift
//  WeatherProject
//
//  Created by Schoo Wer on 15/9/2565 BE.
//

import Foundation
class ForcastWeather {
    var date: String?
    var forcastList: ForcastList? // main
    var weather: [Weather] = [] // weather
    
    init(dictionary: [String: Any]) {
        date = dictionary["dt_txt"] as? String
        if let weatherArray = dictionary["weather"] as? [[String : Any]] {
            weather = weatherArray.map { Weather(dictionary: $0) }
        }
        if let mainDict = dictionary["main"] as? [String : Any] {
            forcastList = ForcastList(dictionary: mainDict)
        }
    }
}
