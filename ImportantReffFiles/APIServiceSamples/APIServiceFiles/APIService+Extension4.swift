//
//  APIService+Extension4.swift
//  EV Quiz
//
//  Created by Abraham VG on 12/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Alamofire
import UIKit


extension APIService {
    
    //MARK: call Winners listing API - POST
    func callWinnersListingAPI(userWon: Bool,completion: @escaping(Results<ModelClassResponse>) -> ()) {
        let eventID = UserDef.shared.eventid
        print("eventID = \(eventID)😄")
        let userID = UserDef.shared.userid
        let newUserId = userWon ? userID : ""
        print("userID = \(userID)😄, newUserId = \(newUserId)")
        let params = [Constants.Keys.eventid: eventID, Constants.Keys.userid: newUserId] as JSON
        
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.winnersPath)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                print("message = \(message)")
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let eventprize = jsonData[Constants.Keys.eventprize] as? String ?? "0"
                print("eventprize = \(eventprize)")
                gVal.eventprize = eventprize
                
                let winnerprize = jsonData[Constants.Keys.winnerprize] as? String ?? "No winnerprize found"
                gVal.prizeString = winnerprize
                print("winnerprize = \(winnerprize)")
                gVal.totalWinners = jsonData[Constants.Keys.totalwinners] as? String ?? "Total Winners no found"
                print("gVal.totalWinners = \(gVal.totalWinners)")
       
                let classResponse = ModelClassResponse(json: jsonData)
                completion(.Success(classResponse))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
    }
    
    
    //MARK: registerAPI for social media Login
    func simpleRegisterAPI(email: String, fbgoogle: String, completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
//        let params = [Constants.Keys.email: email ] as JSON
        let params = [Constants.Keys.email: email, Constants.Keys.tokenid: gVal.uniqueDeviceID, Constants.Keys.uaeapp: Constants.APPTYPE, Constants.Keys.fbgoogle: fbgoogle] as JSON
        
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.registerAPI)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("JAsonData = \(jsonData)")
                
                gVal.error = jsonData[Constants.Keys.error] as? String ?? "0"
                let classResponse = ModelClassResponse(json: jsonData)
                completion(.Success(classResponse))
                
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: calling API For get the selected Options Count - POST
    func answerCountsAPI(questionid: String, completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
        let eventid = UserDef.shared.eventid
        let params = [Constants.Keys.questionid: questionid, Constants.Keys.eventid: eventid] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.answerCountPath)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
              //  print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let classResponse = ModelClassResponse(json: jsonData)
                
                completion(.Success(classResponse))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
   
    
}
