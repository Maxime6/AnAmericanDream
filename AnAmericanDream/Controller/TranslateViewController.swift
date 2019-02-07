//
//  TranslateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    
    @IBOutlet weak var baseLanguageTextField: UITextField!
    @IBOutlet weak var targetLanguageTextView: UITextView!
    
    let translateService = TranslateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func translateButton(_ sender: Any) {
        baseLanguageTextField.resignFirstResponder()
        guard let baseLanguageText = baseLanguageTextField.text else { return }
        
        translateService.getTranslation(textToTranslate: baseLanguageText) { (success, translateData) in
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
