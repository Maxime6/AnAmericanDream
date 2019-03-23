//
//  ExchangeRateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    @IBOutlet weak var currentExchangeRateLabel: UILabel!
    
    // MARK: - Properties
    let exchangeRatesService = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDisplayConfig()
        initialNetworkCall()
        
    }
    
    // MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
    
    @IBAction func conversionButton(_ sender: Any) {
        baseCurrencyTextField.resignFirstResponder()
        exchangeRatesService.getExchangeRate { (success, exchangeData) in
            if success, let exchangeData = exchangeData {
                self.calculateTargetCurrency(exchangeData: exchangeData)
            } else {
                self.displayAlert(title: "Error", message: "The conversion could not be done, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    // MARK: - Methods
    
    func addDisplayConfig() {
        baseCurrencyTextField.borderStyle = .roundedRect
        targetCurrencyLabel.layer.cornerRadius = 3
    }
    
    func initialNetworkCall() {
        exchangeRatesService.getExchangeRate { (success, exchangeData) in
            if success, let exchangeData = exchangeData {
                self.update(exchangeData: exchangeData)
            } else {
                // Message d'erreur
                self.displayAlert(title: "Error", message: "The conversion could not be done, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    func baseCurrencyTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        baseCurrencyTextField.resignFirstResponder()
        return true
    }
    
    // Update the exchange rate
    private func update(exchangeData: ExchangeData) {
        currentExchangeRateLabel.text = String(exchangeData.rates.usd) + "$"
    }
    
    // Calculate target currency
    private func calculateTargetCurrency(exchangeData: ExchangeData) {
        guard let baseCurrencyText = baseCurrencyTextField.text else { return }
        guard let baseCurrencyDouble = Double(baseCurrencyText) else {
            self.displayAlert(title: "Error", message: "Please enter numbers.", preferredStyle: .alert)
            return
        }
        let result = exchangeData.rates.usd * baseCurrencyDouble
        targetCurrencyLabel.text = String(result) + "$"
        
    }
    
}
