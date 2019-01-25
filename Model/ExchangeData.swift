//
//  Rates.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

struct ExchangeData: Decodable {
    let rates: Rates
}

struct Rates: Decodable {
    let usd: Double
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
