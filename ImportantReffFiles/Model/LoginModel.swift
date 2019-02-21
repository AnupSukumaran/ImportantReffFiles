//
//  LoginModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class LoginModel {
    
    let userid: String?
    let username: String?
    let email: String?
    let message: String?
    let error: String?
    
    init(json: JSON ) {
        
        let userid = json[Constants.Keys.userid] as? String
        let username = json[Constants.Keys.username] as? String
        let email = json[Constants.Keys.email] as? String
        let message = json[Constants.Keys.message] as? String
        let error = json[Constants.Keys.error] as? String
        
        self.userid = userid
        self.username = username
        self.email = email
        self.message = message
        self.error = error
    }
}
