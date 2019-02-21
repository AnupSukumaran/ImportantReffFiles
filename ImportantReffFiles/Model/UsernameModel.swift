//
//  UsernameModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 04/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class UsernameModel {
    
    let userid: String?
    let message: String?
    let error: String?
    
    init(json: JSON ) {
        
        let userid = json[Constants.Keys.userid] as? String
        let message = json[Constants.Keys.message] as? String
        let error = json[Constants.Keys.error] as? String
        
        self.userid = userid
        self.message = message
        self.error = error
    }
}
