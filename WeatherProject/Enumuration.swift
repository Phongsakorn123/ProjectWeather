//
//  Enumuration.swift
//  WeatherProject
//
//  Created by Schoo Wer on 15/9/2565 BE.
//

import Foundation
enum TempType {
    case celsius
    case fahrenheit
    
    var titleButton: String {
        switch self {
        case .celsius:
            return "Convert to fahrenheit"
        case .fahrenheit:
            return "Convert to celsius"
        }
    }
}
