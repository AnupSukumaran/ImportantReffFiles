//
//  QuestionsModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 09/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation

class QuestionsModel {
    
    let questionid: String?
    let starttime: String?
    let endtime: String?
    let duration: String?
    let question: String?
    let videoexists: String?
    let audioexists: String?
    let answers: [String]?
    let correctanswer: String?
    let imageexists: String?
    let answerdescription: String?
    let youtubelink: String?
    let introtimerstarttime: String?
    let introtimerendtime: String?
    
    init?(json: JSON) {
        
        let questionid = json[Constants.Keys.questionid] as? String
        let question = json[Constants.Keys.question] as? String
        let videoexists = json[Constants.Keys.videoexists] as? String
        let audioexists = json[Constants.Keys.audioexists] as? String
        let imageexists = json[Constants.Keys.imageexists] as? String
        let answers = json[Constants.Keys.answers] as? [String]
        let correctanswer = json[Constants.Keys.correctanswer] as? String
        let answerdescription = json[Constants.Keys.answerdescription] as? String
        let youtubelink = json[Constants.Keys.youtubelink] as? String
        let starttime = json[Constants.Keys.starttime] as? String
        let endtime = json[Constants.Keys.endtime] as? String
        let duration = json[Constants.Keys.duration] as? String
        let introtimerstarttime = json[Constants.Keys.introtimerstarttime] as? String
        let introtimerendtime = json[Constants.Keys.introtimerendtime] as? String
        
        self.questionid = questionid
        self.question = question
        self.videoexists = videoexists
        self.audioexists = audioexists
        self.answers = answers
        self.correctanswer = correctanswer
        self.imageexists = imageexists
        self.answerdescription = answerdescription
        self.youtubelink = youtubelink
        self.starttime = starttime
        self.endtime = endtime
        self.duration = duration
        self.introtimerstarttime = introtimerstarttime
        self.introtimerendtime = introtimerendtime
        
    }
    
}
