//
//  LeaderboardModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 05/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation

class LeaderboardModel {
    
    
    let userid: String?
    let username: String?
    let score: String?
    
    
    init(json: JSON ) {
        
        let userid = json[Constants.Keys.userid] as? String
        let username = json[Constants.Keys.username] as? String
        let score = json[Constants.Keys.score] as? String
        
        
        self.userid = userid
        self.username = username
        self.score = score
       
    }
    
    
    
}
