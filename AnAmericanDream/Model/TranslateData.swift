//
//  TranslateData.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 30/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

struct TranslateData: Decodable {
    let data: DataClass
}

struct DataClass: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
