//
//  ModelClassResponse.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class ModelClassResponse {
    
    var loginModel = [LoginModel]()
    var registerModel = [RegisterModel]()
    var otpModel = [OTPModel]()
    var forgotModel = [ForgotModel]()
    var usernameModel = [UsernameModel]()
    var changePassModel = [ChangePassModel]()
    var homePageModel = [HomePageModel]()
    var weeklybasedLeaders = [LeaderboardModel]()
    var allTimebasedLeaders = [LeaderboardModel]()
    var questionsModel = [QuestionsModel]()
    var winnersModel = [WinnersModel]()
    var optionsModel = [OptionsModel]()
    var userMedalModel = [UserMedalModel]()
    
    init(json: JSON) {
        
        //MARK: class response For Login
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let loginModel = userinfo.map { LoginModel.init(json: $0)}.compactMap{$0}
            self.loginModel = loginModel
        } else {print("Login😩")}
        
        //MARK: class response For Register
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let registerModel = userinfo.map { RegisterModel.init(json: $0)}.compactMap{$0}
            self.registerModel = registerModel
        } else {print("Register😩")}
        
        //MARK: class response For OTP
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let otpModel = userinfo.map { OTPModel.init(json: $0)}.compactMap{$0}
            self.otpModel = otpModel
        } else {print("otp😩")}
        
        
        //MARK: class response For forgot
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let forgotModel = userinfo.map { ForgotModel.init(json: $0)}.compactMap{$0}
            self.forgotModel = forgotModel
        } else {print("forgotModel😩")}
        
        //MARK: class response For username
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let usernameModel = userinfo.map { UsernameModel.init(json: $0)}.compactMap{$0}
            self.usernameModel = usernameModel
        } else {print("usernameModel😩")}
        
        //MARK: class response For changePassModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let changePassModel = userinfo.map { ChangePassModel.init(json: $0)}.compactMap{$0}
            self.changePassModel = changePassModel
        } else {print("changePassModel😩")}
        
        //MARK: class response For homePageModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let homePageModel = userinfo.map { HomePageModel.init(json: $0)}.compactMap{$0}
            self.homePageModel = homePageModel
        } else {print("homePageModel😩")}
        
        //MARK: class response For leaderboardModel
        if let userinfo = json[Constants.Keys.userinfo] as? JSON, let weeklyArray = userinfo[Constants.Keys.thisWeek] as? [JSON], let allTime = userinfo[Constants.Keys.allTime] as? [JSON]   {
            
            let weeklybasedLeaders = weeklyArray.map { LeaderboardModel.init(json: $0)}.compactMap{$0}
            let allTimebasedLeaders = allTime.map{ LeaderboardModel.init(json: $0)}.compactMap{$0}
            
            self.weeklybasedLeaders = weeklybasedLeaders
            self.allTimebasedLeaders = allTimebasedLeaders
        } else {print("leaderboardModel😩")}
        
        //MARK: class response For questionsModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let questionsModel = userinfo.map { QuestionsModel.init(json: $0)}.compactMap{$0}
            self.questionsModel = questionsModel
        } else {print("questionsModel😩")}
        
        //MARK: class response For WinnersModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let winnersModel = userinfo.map { WinnersModel.init(json: $0)}.compactMap{$0}
            self.winnersModel = winnersModel
        } else {print("winnersModel😩")}
        
        //MARK: class response For optionsModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let optionsModel = userinfo.map { OptionsModel.init(json: $0)}.compactMap{$0}
            self.optionsModel = optionsModel
        } else {print("optionsModel😩")}

        //MARK: class response For userMedalModel
        if let userinfo = json[Constants.Keys.userinfo] as? [JSON] {
            let userMedalModel = userinfo.map { UserMedalModel.init(json: $0)}.compactMap{$0}
            self.userMedalModel = userMedalModel
        } else {print("userMedalModel😩")}
    }
    
}
