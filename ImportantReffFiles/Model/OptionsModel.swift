//
//  OptionsModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 16/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class OptionsModel {
    
    let eventid: String?
    let questionid: String?
    let answer1: String?
    let answer2: String?
    let answer3: String?
    let answer4: String?
    
    
    init?(json: JSON) {
        let eventid = json[Constants.Keys.eventid] as? String
        let questionid = json[Constants.Keys.questionid] as? String
        let answer1 = json[Constants.Keys.answer1] as? String
        let answer2 = json[Constants.Keys.answer2] as? String
        let answer3 = json[Constants.Keys.answer3] as? String
        let answer4 = json[Constants.Keys.answer4] as? String
        
        self.eventid = eventid
        self.questionid = questionid
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
    }
}
