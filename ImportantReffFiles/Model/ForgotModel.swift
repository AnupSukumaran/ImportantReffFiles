//
//  ForgotModel.swift
//  EV Quiz
//
//  Created by Sukumar Anup Sukumaran on 03/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class ForgotModel {
    
    let email: String?
    let message: String?
    let error: String?
    
    init(json: JSON ) {
        
        let email = json[Constants.Keys.email] as? String
        let message = json[Constants.Keys.message] as? String
        let error = json[Constants.Keys.error] as? String
        
        self.email = email
        self.message = message
        self.error = error
    }
}
