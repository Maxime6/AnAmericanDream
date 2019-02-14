//
//  WheatherService.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 10/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

class WheatherService {
    
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getWheather(city: String, callback: @escaping (Bool, WheatherData?) -> Void ) {
        let stringUrl = createWheatherUrl(city: city)
        guard let url = URL(string: stringUrl) else { return }
        
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WheatherData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    func createWheatherUrl(city: String) -> String {
        let appid = "7a05ae3a0fef0a5f93ae437fc99b9a00"
        let q = city
        let units = "metric"
        
        var urlComponents = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
        urlComponents?.queryItems = [
            URLQueryItem(name: "APPID", value: appid),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "units", value: units)
        ]
        
        return (urlComponents?.url?.absoluteString)!
    }
    
}
