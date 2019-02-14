//
//  WeatherViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var wheatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var newyorkButton: UIButton!
    @IBOutlet weak var lorientButton: UIButton!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    
    let weatherService = WheatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newyorkButton.layer.cornerRadius = 6
        lorientButton.layer.cornerRadius = 6
        
    }
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        
        guard let cityChoosed = sender.title(for: .normal) else { return }
        
        weatherService.getWheather(city: cityChoosed) { (success, weatherData) in
            if success, let weatherData = weatherData {
                self.displayWeatherConditions(weatherData: weatherData)
            } else {
                // Alerte
                self.displayAlert(title: "Error", message: "The weather could not be display, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    // Display all weather conditions
    private func displayWeatherConditions(weatherData: WheatherData) {
        weatherDescriptionLabel.text = weatherData.weather[0].description
        temperatureLabel.text = String(weatherData.main.temp) + "°"
        windDirection(weatherData: weatherData)
        calculateWindSpeed(weatherData: weatherData)
        cloudinessLabel.text = String(weatherData.clouds.all)
        humidityLabel.text = String(weatherData.main.humidity)
    }
    
    // Display the wind direction in cardinals directions
    private func windDirection(weatherData: WheatherData) {
        let windDirection = weatherData.wind.deg
        
        switch windDirection {
        case 0...44 :
            windDirectionLabel.text = "N"
        case 45...134:
            windDirectionLabel.text = "E"
        case 135...224:
            windDirectionLabel.text = "S"
        case 225...314:
            windDirectionLabel.text = "O"
        case 315...360:
            windDirectionLabel.text = "N"
        default:
            break
        }
    }
    
    // Calculate wind speed in km/h
    private func calculateWindSpeed(weatherData: WheatherData) {
        let result = weatherData.wind.speed * 3.6
        windSpeedLabel.text = String(result) + "km/h"
    }
    
    private func displayWeatherIcon(weatherData: WheatherData) {
        let weatherCode = weatherData.weather[0].id
        
//        switch weatherCode {
//        case 200...299:
//            wheatherIconImageView.image = UIImage(named: "storm")
//        case 300...399:
//
//        case 500...599:
//
//        case 600...699:
//
//        case 700...799:
//
//        case 800:
//
//        case 801...899:
//
//        default:
//            break
//        }
    }
    
}
