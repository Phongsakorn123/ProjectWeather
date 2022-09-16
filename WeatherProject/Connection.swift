//
//  Connection.swift
//  WeatherProject
//
//  Created by Schoo Wer on 10/9/2565 BE.
//

import Foundation
import ProgressHUD
import Alamofire
import AlamofireImage

enum Environment {
    case DEV
    case UAT
    case PRODUCTION
}

// Environment
var environment: Environment = .UAT

// Protocal
var protocal: String {
    switch environment {
    case .DEV:
        return "https://"
    case .UAT:
        return "https://"
    case .PRODUCTION:
        return "https://"
    }
}

// Base URL
var baseURL: String {
    switch environment {
    case .DEV:
        return "api.openweathermap.org/"
    case .UAT:
        return "api.openweathermap.org/"
    case .PRODUCTION:
        return "api.openweathermap.org/"
    }
}

// Version
var version: String {
    switch environment {
    case .DEV:
        return "2.5/"
    case .UAT:
        return "2.5/"
    case .PRODUCTION:
        return "2.5/"
    }
}

enum API {
    case getWeather
    case getIconWeather(nameID: String)
    case getWeatherRange
    var resource: String {
        switch self {
        case .getWeather:
            return "data/\(version)/weather"
        case .getIconWeather(let nameID):
            return "openweathermap.org/img/wn/\(nameID)@2x.png"
        case .getWeatherRange:
            return "data/\(version)/forecast"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        case .getIconWeather:
            return .get
        case .getWeatherRange:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getWeather:
            return URLEncoding.queryString
        case .getWeatherRange:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
    var url: String {
        switch self {
        case .getWeather:
            return protocal + baseURL + resource
        case .getIconWeather:
            return protocal + resource
        case .getWeatherRange:
            return protocal + baseURL + resource
        }
    }
}

class Connection {
    class func request(api: API, parameters: Parameters? = nil, enableHud: Bool = true, completion: @escaping(_ data: Any?) -> Void) {
        
        if enableHud {
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.colorAnimation = #colorLiteral(red: 0.1215686275, green: 0.5333333333, blue: 0.8980392157, alpha: 1)
            ProgressHUD.show(nil, interaction: false)
        }
        
        AF.request(api.url, method: api.method, parameters: parameters, encoding: api.encoding).responseJSON { response in
            debugPrint(response)
            
            if enableHud {
                ProgressHUD.dismiss()
            }
            
            switch response.result {
            case .success:
                    switch api {
                    case .getWeather, .getIconWeather, .getWeatherRange:
                        completion(response.value)
                    }
                var data: Any? = nil
                data = response.value
                completion(data)
                return
                
            case .failure(_):
                ProgressHUD.dismiss()
                
                    if let data = response.data {
                        print(String(data: data, encoding: String.Encoding.utf8) ?? "")
                    }
            }
        }
    }
    
    
    
    
    class func requestImage(api: API, parameters: Parameters? = nil, enableHud: Bool = true, completion: @escaping(_ image: Any?) -> Void) {
        
        if enableHud {
            ProgressHUD.animationType = .circleStrokeSpin
            ProgressHUD.colorAnimation = #colorLiteral(red: 0.1215686275, green: 0.5333333333, blue: 0.8980392157, alpha: 1)
            ProgressHUD.show(nil, interaction: false)
        }
        
        AF.request(api.url, method: api.method, parameters: parameters, encoding: api.encoding).responseImage { response in
            debugPrint(response)
            
            if enableHud {
                ProgressHUD.dismiss()
            }
            
            switch response.result {
            case .success:
                    switch api {
                    case .getWeather, .getIconWeather, .getWeatherRange:
                        completion(response.value)
                    }
                var image: Any? = nil
                image = response.value
                completion(image)
                return
                
            case .failure(_):
                ProgressHUD.dismiss()
                
                    if let data = response.data {
                        print(String(data: data, encoding: String.Encoding.utf8) ?? "")
                    }
            }
        }
    }
}
