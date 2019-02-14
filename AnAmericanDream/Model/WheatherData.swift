//
//  WheatherData.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 10/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

struct WheatherData: Decodable {
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
    
//    enum CodingKeys: String, CodingKey {
//        case temp, humidity
//    }
}

struct Weather: Decodable {
    let id: Int
    let main, description: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
