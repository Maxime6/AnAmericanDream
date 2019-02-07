//
//  UIAlert.swift
//  AnAmericanDream
//
//  Created by Yves TANTER on 07/02/2019.
//  Copyright © 2019 Maxime Tanter. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}
