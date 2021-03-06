//
//  TranslateService.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 30/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

class TranslationService {
    
    // MARK: - Properties
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    var languages = ["en", "es", "de", "it"]
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Network Call
    func getTranslation(textToTranslate: String, translationLanguage: String, callback: @escaping (Bool, TranslateData?) -> Void) {
        let stringUrl = createTransleteStringUrl(textToTranslate: textToTranslate, translationLanguage: translationLanguage)
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
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    private func createTransleteStringUrl(textToTranslate: String, translationLanguage: String) -> String {
        let key = "AIzaSyBlTMupeJcRAQd0w8VXT38HTv82xGPzMOo"
        let source = "fr"
        let target = translationLanguage
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

        guard let urlComponent = urlComponents?.url else { return "" }
        
        return urlComponent.absoluteString
    }
    
}
