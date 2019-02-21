//
//  APIService+Extension6.swift
//  EV Quiz
//
//  Created by Abraham VG on 26/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Alamofire
import UIKit


extension APIService {
    
    //MARK: REFERRAL CODE API
    func referralCodeAPI(username: String,completion: @escaping(Results<String>) -> ()) {
        
        let userid = UserDef.shared.userid
        
        let params = [Constants.Keys.username: username, Constants.Keys.userid:userid] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.applyReferralCode)
      //  print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
           
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("JsonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
    }
    
    //MARK: ADD EXTRA LIFE API
    func addExtraLifeAPI(extraLife: String, paidLife: Bool,amount: String, completion: @escaping(Results<String>) -> ()) {
        
        let email = UserDef.shared.email
        let userid = UserDef.shared.userid
        var params = JSON()
        
        if paidLife {
            params = [Constants.Keys.email: email, Constants.Keys.extralife: extraLife, Constants.Keys.userid: userid, Constants.Keys.amount: amount] as JSON
        } else {
            params = [Constants.Keys.email: email, Constants.Keys.extralife: extraLife, Constants.Keys.userid: userid] as JSON
        }
        
        
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.addExtraLifePath)
        print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("JsonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: TOKEN API
    func tokenAPI(token: String, completion: @escaping(Results<String>) -> () ) {
        
        let params = [Constants.Keys.token: token] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.tokenInsertPath)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
           
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("JsonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
        
    }
}
