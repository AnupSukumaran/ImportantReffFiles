//
//  HomePageModel.swift
//  EV Quiz
//
//  Created by Abraham VG on 04/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation



class HomePageModel {
    
    let userid: String?
    let username: String?
    let profilepicture: String?
    let balanceamount: String?
    let totallives: String?
    let email: String?
    let eventtime: String?
    let eventname: String?
    let eventid: String?
    let eventprize: String?
    let eventdescription: String?
    let medals: String?
    let advideo: String?
    let currentgmt: String? 
    let allowedlives: String?
    let advideoid: String?
    
    init(json: JSON ) {
        
        let userid = json[Constants.Keys.userid] as? String
        let username = json[Constants.Keys.username] as? String
        let profilepicture = json[Constants.Keys.profilepicture] as? String
        let balanceamount = json[Constants.Keys.balanceamount] as? String
        let totallives = json[Constants.Keys.totallives] as? String
        let email = json[Constants.Keys.email] as? String
        let eventtime = json[Constants.Keys.eventtime] as? String
        let eventname = json[Constants.Keys.eventname] as? String
        let eventid = json[Constants.Keys.eventid] as? String
        let eventprize = json[Constants.Keys.eventprize] as? String
        let eventdescription = json[Constants.Keys.eventdescription] as? String
        let medals = json[Constants.Keys.medals] as? String
        let advideo = json[Constants.Keys.advideo] as? String
        let currentgmt = json[Constants.Keys.currentgmt] as? String
        let allowedlives = json[Constants.Keys.allowedlives] as? String
        let advideoid = json[Constants.Keys.advideoid] as? String
         
        self.userid = userid
        self.username = username
        self.profilepicture = profilepicture
        self.balanceamount = balanceamount
        self.totallives = totallives
        self.email = email
        self.eventtime = eventtime
        self.eventname = eventname
        self.eventid = eventid
        self.eventprize = eventprize
        self.eventdescription = eventdescription
        self.medals = medals
        self.advideo = advideo
        self.currentgmt = currentgmt
        self.allowedlives = allowedlives
        self.advideoid = advideoid
        
    }
}
