//
//  TranslateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var baseLanguageTextView: UITextView!
    @IBOutlet weak var targetLanguageTextView: UITextView!
    
    let translationService = TranslationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func translateButton(_ sender: Any) {
        baseLanguageTextView.resignFirstResponder()
        guard let baseLanguageText = baseLanguageTextView.text else { return }
        
        translationService.getTranslation(textToTranslate: baseLanguageText) { (success, translateData) in
            if success, let translateData = translateData {
                // traduire le texte
                let translatedText = translateData.data.translations[0].translatedText
                self.targetLanguageTextView.text = translatedText
            } else {
                // Alert message
                self.displayAlert(title: "Error", message: "The translation could not be done, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
}
