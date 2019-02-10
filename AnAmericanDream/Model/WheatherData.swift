//
//  WheatherData.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 10/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

struct WheatherData: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Main: Decodable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Rain: Decodable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct Sys: Decodable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
