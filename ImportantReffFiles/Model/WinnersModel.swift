//
//  WinnersModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 12/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class WinnersModel {
    
    let userid: String?
    let username: String?
    
    
    init?(json: JSON) {
        
        let userid = json[Constants.Keys.userid] as? String
        let username = json[Constants.Keys.username] as? String
        self.userid = userid
        self.username = username
    
    }
    
}
