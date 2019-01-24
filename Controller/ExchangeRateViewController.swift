//
//  ExchangeRateViewController.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 24/01/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currentExchangeRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseCurrencyTextField.borderStyle = .roundedRect
        targetCurrencyTextField.borderStyle = .roundedRect
    }
    
}
