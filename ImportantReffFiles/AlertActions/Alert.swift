//
//  Alert.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    
    static func showAlert(title: String, message: String, buttonTitle: String, selfClass: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        
        selfClass.present(alert, animated: true, completion: nil)
        
    }
    
    static func showAlertWithComBLK(title: String, message: String, buttonTitle: String, selfClass: UIViewController, comBLK: @escaping() -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            comBLK()
        }
        
        alert.addAction(action)
        selfClass.present(alert, animated: true, completion: nil)
        
    }
    
}

