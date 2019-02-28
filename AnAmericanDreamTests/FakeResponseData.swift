//
//  FakeResponseData.swift
//  AnAmericanDreamTests
//
//  Created by Yves TANTER on 14/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let error = NetworkError()
    
    static var exchangeRateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRateData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let networkIncorrectData = "erreur".data(using: .utf8)!
    
}
