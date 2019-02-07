//
//  ExchangeRate.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

class ExchangeRateService {
    
//    private let exchangeRateUrl = URL(string: "http://data.fixer.io/api/latest?access_key=6828305824724f292feaea538719ac6e&base=EUR&symbols=USD")!
    
    private var task: URLSessionDataTask?
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func getExchangeRate(callback: @escaping ((Bool, ExchangeData?) -> Void)) {
        task?.cancel()
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=6828305824724f292feaea538719ac6e&base=EUR&symbols=USD") else { return }
        
        task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJson = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJson)
            }
        })
        task?.resume()
    }
    
}
