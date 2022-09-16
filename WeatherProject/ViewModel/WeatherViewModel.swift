//
//  WeatherViewModel.swift
//  WeatherProject
//
//  Created by Schoo Wer on 12/9/2565 BE.
//

import Foundation
import Alamofire
class WeatherViewModel {
    func requestWeatherCity(city: String, appid: String, completion: @escaping(_ data: Any?) -> Void) {
        var parameters = Parameters()
        parameters = ["q": city, "appid": appid]
        Connection.request(api: .getWeather, parameters: parameters) { data in
            guard let dataDict = data as? [String: Any] else { return }
            completion(dataDict)
        }
    }
}
