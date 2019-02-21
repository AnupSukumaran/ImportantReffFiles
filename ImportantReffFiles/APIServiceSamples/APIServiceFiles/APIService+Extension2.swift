//
//  APIService+Extension2.swift
//  EV Quiz
//
//  Created by Sukumar Anup Sukumaran on 04/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//


import Alamofire

extension APIService {
    
    //MARK: Home API function - GET
    func homeAPI(completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
        let email = UserDef.shared.email
        let userid = UserDef.shared.userid
        print("email = \(email)😄")
        print("userid = \(userid)😄")
        let params = [Constants.Keys.email: email, Constants.Keys.userid: userid, Constants.Keys.tokenid: gVal.uniqueDeviceID] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.homeAPI)
        //print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again.\(String(describing: response.response?.statusCode))"))
                return
            }
            
            switch response.result {
                
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                //print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let classResponse = ModelClassResponse(json: jsonData)
                
                completion(.Success(classResponse))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
    }
    
    
    //MARK: Verify Username API function - POST
    func verifyusernameAPI(username: String,completion: @escaping(Results<String>) -> ()) {
       print("username = \(username)😄")
        let params = [Constants.Keys.username: username] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.verifyusernameAPI)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
            //    print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                //let classResponse = ModelClassResponse(json: jsonData)
                //                let message = classResponse.changePassModel.first?.message ?? "No Message Found"
                //                guard classResponse.changePassModel.first?.error == "0" else {completion(.Error(message));return}
                completion(.Success(message))
                
            case .failure(_):
                completion(.Error(Constants.serErrorMsg))
            }
        }
    }
    
    //MARK: Verify Leaderboard API function - GET
    func leaderboardAPI(completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
        //let params = ["":""] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.leaderboardAPI)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .get, parameters: [:]).validate().responseJSON { (response) in
           
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
           //     print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let classResponse = ModelClassResponse(json: jsonData)
                
                completion(.Success(classResponse))
                
            case .failure(_):
                completion(.Error(Constants.serErrorMsg))
            }
        }
    }
}
