//
//  VerifyUsernameModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 04/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation



class VerifyUsernameModel {
    
    let userid: String?
    
    
    init(json: JSON ) {
        
        let userid = json[Constants.Keys.userid] as? String
        self.userid = userid
       
    }
}
