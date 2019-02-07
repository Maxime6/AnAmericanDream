//
//  TranslateService.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 30/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

class TranslateService {
    
//    private let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBlTMupeJcRAQd0w8VXT38HTv82xGPzMOo&source=fr&target=en&format=text")!
    
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getTranslation(textToTranslate: String, callback: @escaping (Bool, TranslateData?) -> Void) {
        let stringUrl = createTransleteStringUrl(textToTranslate: textToTranslate)
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
                guard let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                        callback(false, nil)
                        return
                }
            }
        }
        task?.resume()
    }
    
    private func createTransleteStringUrl(textToTranslate: String) -> String {
        // Assembler URL avec q + textToTranslate
        let key = "AIzaSyBlTMupeJcRAQd0w8VXT38HTv82xGPzMOo"
        let source = "fr"
        let target = "en"
        let format = "text"
        let q = textToTranslate
        
        var urlComponents = URLComponents(string: "https://translation.googleapis.com/language/translate/v2")
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "source", value: source),
            URLQueryItem(name: "target", value: target),
            URLQueryItem(name: "format", value: format),
            URLQueryItem(name: "q", value: q)
        ]
        
        return (urlComponents?.url?.absoluteString)!
    }
    
}
