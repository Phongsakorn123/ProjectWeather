//
//  Weather.swift
//  WeatherProject
//
//  Created by Schoo Wer on 12/9/2565 BE.
//

import Foundation
class Weather: NSObject {
    var id: Int?
    var weatherName: String?
    var detail: String?
    var iconID: String?
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int
        weatherName = dictionary["main"] as? String
        detail = dictionary["description"] as? String
        iconID = dictionary["icon"] as? String
    }
}
