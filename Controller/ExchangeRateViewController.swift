//
//  ExchangeRateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit
import QuartzCore

class ExchangeRateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentExchangeRateLabel: UILabel!
    
    let exchangeRatesService = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseCurrencyTextField.borderStyle = .roundedRect
        self.targetCurrencyLabel.layer.cornerRadius = 3
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                // Faire la conversion et l'afficher dans le label Target
//                self.update(exchangeData: exchangeData)
                self.calculTargetCurrency(exchangeData: exchangeData)
            } else {
                // Message d'erreur
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
    }
    
    private func calculTargetCurrency(exchangeData: ExchangeData) {
        // Calculer le taux de change pour la somme demandé
        
        let result = exchangeData.rates.usd * Double(baseCurrencyTextField.text!)!
        targetCurrencyLabel.text = String(result)
        
    }
    
}
