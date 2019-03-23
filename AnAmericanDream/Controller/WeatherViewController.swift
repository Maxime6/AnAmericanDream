//
//  WeatherViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var wheatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var newyorkButton: UIButton!
    @IBOutlet weak var lorientButton: UIButton!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    
    // MARK: - Properties
    private let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCornerRadius()
        initialNetworkCall()
        
    }
    
    // MARK: - Actions
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        
        guard let cityChoosed = sender.title(for: .normal) else { return }
        sender.backgroundColor = UIColor(red: 255.0, green: 212.0, blue: 121.0, alpha: 1)
        
        weatherService.getWheather(city: cityChoosed) { (success, weatherData) in
            if success, let weatherData = weatherData {
                self.displayWeatherConditions(weatherData: weatherData)
            } else {
                // Alerte
                self.displayAlert(title: "Error", message: "The weather could not be display, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    // MARK: - Methods
    func addCornerRadius() {
        newyorkButton.layer.cornerRadius = 6
        lorientButton.layer.cornerRadius = 6
    }
    
    func initialNetworkCall() {
        weatherService.getWheather(city: "New York") { (success, weatherData) in
            if success, let weatherData = weatherData {
                self.displayWeatherConditions(weatherData: weatherData)
            } else {
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
        cloudinessLabel.text = String(weatherData.clouds.all) + "%"
        humidityLabel.text = String(weatherData.main.humidity) + "%"
        displayWeatherIcon(weatherData: weatherData)
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
        let result = Float(weatherData.wind.speed * 3.6)
        windSpeedLabel.text = String(result) + "km/h"
    }
    
    // Display weather icon
    private func displayWeatherIcon(weatherData: WheatherData) {
        let weatherCode = weatherData.weather[0].id
        
        switch weatherCode {
        case 200...299:
            wheatherIconImageView.image = #imageLiteral(resourceName: "storm")
        case 300...399:
            wheatherIconImageView.image = #imageLiteral(resourceName: "rain")
        case 500...599:
            wheatherIconImageView.image = #imageLiteral(resourceName: "rain")
        case 600...699:
            wheatherIconImageView.image = #imageLiteral(resourceName: "snow")
        case 700...799:
            wheatherIconImageView.image = #imageLiteral(resourceName: "atmosphere")
        case 800:
            wheatherIconImageView.image = #imageLiteral(resourceName: "clear sky")
        case 801...899:
            wheatherIconImageView.image = #imageLiteral(resourceName: "clouds")
        default:
            break
        }
    }
    
}
