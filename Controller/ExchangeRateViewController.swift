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
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    @IBOutlet weak var currentExchangeRateLabel: UILabel!
    
    let exchangeRatesService = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseCurrencyTextField.borderStyle = .roundedRect
        targetCurrencyLabel.layer.cornerRadius = 3
        
        // Appel réseau pour afficher le taux de change
        exchangeRatesService.getExchangeRate { (success, exchangeData) in
            if success, let exchangeData = exchangeData {
                self.update(exchangeData: exchangeData)
            }
        }
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
    
    @IBAction func conversionButton(_ sender: Any) {
        baseCurrencyTextField.resignFirstResponder()
        exchangeRatesService.getExchangeRate { (success, exchangeData) in
            if success, let exchangeData = exchangeData {
                self.calculTargetCurrency(exchangeData: exchangeData)
            } else {
                // Message d'erreur
                self.presentAlert()
            }
        }
    }
    
    func baseCurrencyTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        baseCurrencyTextField.resignFirstResponder()
        return true
    }
    
    private func update(exchangeData: ExchangeData) {
        currentExchangeRateLabel.text = String(exchangeData.rates.usd) + "$"
    }
    
    private func presentAlert() {
        // Alerte d'erreur
        let alertVC = UIAlertController(title: "Error", message: "The conversion failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func calculTargetCurrency(exchangeData: ExchangeData) {
        guard let baseCurrencyText = baseCurrencyTextField.text else { return }
        
        // Vérifier que le text est convertible en double
        let result = exchangeData.rates.usd * Double(baseCurrencyText)!
        targetCurrencyLabel.text = String(result)
        
    }
    
}
