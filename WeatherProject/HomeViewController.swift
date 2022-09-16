//
//  HomeViewController.swift
//  WeatherProject
//
//  Created by Schoo Wer on 12/9/2565 BE.
//

import UIKit
import Alamofire
import Gifu
class HomeViewController: UIViewController {
    @IBOutlet weak var convertTempBtn: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var climateNameLabel: UILabel!
    @IBOutlet weak var climateDetailLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var inputCityTextField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTempImageView: UIImageView!
    var cityName = "Bangkok"
    var appID = "52a07e1637d42dfb61b79749d8fdeeb3"
    var modelMain: ModelMain?
    let weatherViewModel = WeatherViewModel()
    let iconViewModel = IconViewModel()
    var selectTempType: TempType! = .celsius
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCityTextField.text = cityName
        requestWeatherCity()
        
    }
    
    func requestWeatherCity() {
        weatherViewModel.requestWeatherCity(city: cityName, appid: appID) {
            data in
            self.modelMain = ModelMain(dictionary: data as! [String : Any])
            self.setDefault()
        }
    }
    
    @IBAction func searchCity() {
        cityName = inputCityTextField.text!
        weatherViewModel.requestWeatherCity(city: cityName, appid: appID) {
            data in
            self.modelMain = ModelMain(dictionary: data as! [String : Any])
            self.setDefault()
        }
    }
    
    @IBAction func reload() {
        cityName = inputCityTextField.text!
        weatherViewModel.requestWeatherCity(city: cityName, appid: appID) {
            data in
            self.modelMain = ModelMain(dictionary: data as! [String : Any])
            self.setDefault()
        }
    }
    
    
    @IBAction func convertTempType() {
        switch self.selectTempType! {
        case .celsius:
            self.selectTempType = .fahrenheit
            self.convertTempBtn.setTitle(selectTempType.titleButton, for: .normal)
            self.tempLabel.text = String(format: "%.2f", self.modelMain?.tempFahrenheit ?? 00)
            self.iconTempImageView.image = UIImage(named: "fahrenheit")
        case .fahrenheit:
            self.selectTempType = .celsius
            self.convertTempBtn.setTitle(selectTempType.titleButton, for: .normal)
            self.tempLabel.text = String(format: "%.2f", self.modelMain?.tempCelsius ?? 00)
            self.iconTempImageView.image = UIImage(named: "thermometer")
        }
    }
    
    @IBAction func showForcastFiveDay() {
        self.performSegue(withIdentifier: "ShowForcastFiveDay", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "ShowForcastFiveDay" {
            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let homeController = navigationController.viewControllers.first as? ForcastFiveDayVC else {
                return
            }
            homeController.cityName = self.cityName
            homeController.appID = self.appID
        }
    }
    
    func setDefault() {
        if self.modelMain?.cod == 200 {
            self.cityNameLabel.text = self.modelMain?.name
            self.climateNameLabel.text = self.modelMain?.weather.first?.weatherName
            self.climateDetailLabel.text = self.modelMain?.weather.first?.detail
            self.humidityLabel.text = "Humidity: " + String(self.modelMain?.humidity ?? 0) + "%"
            switch self.selectTempType! {
            case .celsius:
                self.selectTempType = .fahrenheit
                self.convertTempBtn.setTitle(selectTempType.titleButton, for: .normal)
                self.tempLabel.text = String(format: "%.2f", self.modelMain?.tempFahrenheit ?? 00)
                self.iconTempImageView.image = UIImage(named: "fahrenheit")
            case .fahrenheit:
                self.selectTempType = .celsius
                self.convertTempBtn.setTitle(selectTempType.titleButton, for: .normal)
                self.tempLabel.text = String(format: "%.2f", self.modelMain?.tempCelsius ?? 00)
                self.iconTempImageView.image = UIImage(named: "thermometer")
            }
            if let nameID = self.modelMain?.weather.first?.iconID {
                self.setIconImage(nameID: nameID)
            }
        }
    }
    
    func setIconImage(nameID: String) {
        iconViewModel.requestWeatherCity(nameID: nameID, enableHud: true) {
            image in
            DispatchQueue.main.async {
                self.iconImageView.image = image as? UIImage
            }
        }
    }
}
