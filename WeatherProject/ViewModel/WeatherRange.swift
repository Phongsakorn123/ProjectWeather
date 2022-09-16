//
//  WeatherRange.swift
//  WeatherProject
//
//  Created by Schoo Wer on 13/9/2565 BE.
//

import Foundation
import Alamofire
class WeatherRange {
    func requestWeatherRange(city: String, appid: String, completion: @escaping(_ data: [[String:Any]]) -> Void) {
        let parameters: Parameters = ["q": city, "appid": appid]
        Connection.request(api: .getWeatherRange, parameters: parameters) { data in
            guard let dataDict = data as? [String: Any] else { return }
            let array = dataDict["list"] as? [[String: Any]]
            completion(array!)
        }
    }
}
