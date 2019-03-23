//
//  TranslateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var baseLanguageTextView: UITextView!
    @IBOutlet weak var targetLanguageTextView: UITextView!
    @IBOutlet weak var targetLanguagePickerView: UIPickerView!
    
    // MARK: - Properties
    private let translationService = TranslationService()
    var translationLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseLanguageTextView.resignFirstResponder()
    }
    
    @IBAction func translateButton(_ sender: Any) {
        baseLanguageTextView.resignFirstResponder()
        guard let baseLanguageText = baseLanguageTextView.text else { return }
        
        translationService.getTranslation(textToTranslate: baseLanguageText, translationLanguage: translationLanguage) { (success, translateData) in
            if success, let translateData = translateData {
                let translatedText = translateData.data.translations[0].translatedText
                self.targetLanguageTextView.text = translatedText
            } else {
                self.displayAlert(title: "Error", message: "The translation could not be done, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    // MARK:  - Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return translationService.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        translationLanguage = translationService.languages[row]
        return translationService.languages[row]
    }
    
}
