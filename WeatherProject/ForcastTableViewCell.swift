//
//  ForcastTableViewCell.swift
//  WeatherProject
//
//  Created by Schoo Wer on 15/9/2565 BE.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var climateDetailLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var forcastWeather: ForcastWeather! {
        didSet {
            dateLabel.text = "Date: " + forcastWeather.date!
            climateLabel.text = "Climate: " + (forcastWeather.weather.first?.weatherName)!
            climateDetailLabel.text = "Climate Detail: " + (forcastWeather.weather.first?.detail)!
            tempLabel.text = "Temp: " + String(format: "%.2f", forcastWeather.forcastList?.tempCelsius ?? 00) + " Celsius   " + String(format: "%.2f", forcastWeather.forcastList?.tempFahrenheit ?? 00) + " Fahrenheit"
            humidityLabel.text = "Humidity: " + String(forcastWeather.forcastList?.humidity ?? 00) + "%"
       
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
