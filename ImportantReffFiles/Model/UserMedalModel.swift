//
//  UserMedalModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 25/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class UserMedalModel {
    
    let medalid: String?
    let medalname: String?
    let totalwins: String?
    let level: String?
    
    
    init?(json: JSON) {
        let medalid = json[Constants.Keys.medalid] as? String
        let medalname = json[Constants.Keys.medalname] as? String
        let totalwins = json[Constants.Keys.totalwins] as? String
        let level = json[Constants.Keys.level] as? String
        
        
        self.medalid = medalid
        self.medalname = medalname
        self.totalwins = totalwins
        self.level = level
        
    }
}
