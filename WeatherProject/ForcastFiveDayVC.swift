//
//  ForcastFiveDayVC.swift
//  WeatherProject
//
//  Created by Schoo Wer on 15/9/2565 BE.
//

import UIKit
import Alamofire
class ForcastFiveDayVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cityName: String!
    var appID: String!
    var forcastWeather: [ForcastWeather] = []
    var forcastWeatherImage: [UIImage] = []
    let weatherRange = WeatherRange()
    let iconViewModel = IconViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        requestForcastList()
    }
    
    private func requestForcastList() {
        weatherRange.requestWeatherRange(city: cityName, appid: appID) { data in
                self.forcastWeather = data.map { ForcastWeather(dictionary: $0) }
                self.tableView.reloadData()
        }
    }
    
    @IBAction func selectClose() {
        self.dismiss(animated: true)
    }
}

extension ForcastFiveDayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcastWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForcastCell", for: indexPath) as! ForcastTableViewCell
        cell.forcastWeather = self.forcastWeather[indexPath.row]
        cell.cityNameLabel.text = self.cityName
        iconViewModel.requestWeatherCity(nameID: (self.forcastWeather[indexPath.row].weather.first?.iconID!)!, enableHud: false) {
            image in
            DispatchQueue.main.async {
                cell.iconImageView.image = image as? UIImage
            }
        }
        return cell
    }
}
