//
//  IconViewModel.swift
//  WeatherProject
//
//  Created by Schoo Wer on 12/9/2565 BE.
//

import Foundation
import Kingfisher
class IconViewModel {
    func requestWeatherCity(nameID: String, enableHud: Bool, completion: @escaping(_ image: Any?) -> Void) {
        Connection.requestImage(api: .getIconWeather(nameID: nameID), enableHud: enableHud) { image in
            guard let image = image else { return }
            completion(image)
        }
    }
}
