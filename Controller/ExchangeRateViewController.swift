//
//  ExchangeRateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentExchangeRateLabel: UILabel!
    
    let exchangeRatesService = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseCurrencyTextField.borderStyle = .roundedRect
        targetCurrencyTextField.borderStyle = .roundedRect
        
        exchangeRatesService.getExchangeRate { (success, exchangeData) in
            if success {
                guard let exchangeData = exchangeData else { return }
                print(exchangeData)
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
    
    @IBAction func conversionButton(_ sender: Any) {
        baseCurrencyTextField.resignFirstResponder()
    }
    
    func baseCurrencyTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        baseCurrencyTextField.resignFirstResponder()
        return true
    }
    
}
