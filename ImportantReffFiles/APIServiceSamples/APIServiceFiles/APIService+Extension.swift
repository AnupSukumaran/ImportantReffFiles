//
//  APIService+Extension.swift
//  EV Quiz
//
//  Created by Abraham VG on 04/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//


import Alamofire

extension APIService {
    
    
    //MARK: ForgotAPI - POST
    func forgotAPI(email: String, completion: @escaping(Results<String>) -> ()) {
        print("Email - \(email)😄")
        let params = [Constants.Keys.email: email ] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.forgotAPI)
       // print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
           
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
             //   print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}

                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: usernameAPI - POST
    func usernameAPI(email: String, username: String, completion: @escaping(Results<String>) -> ()) {

        let params = [Constants.Keys.email: email, Constants.Keys.username: username ] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.usernameAPI)
      //  print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
             //   print("jasonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}

                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: changePassAPI - POST
    func changePassAPI(email: String, oldPassword: String, password: String, completion: @escaping(Results<String>) -> ()) {
        
        let params = [Constants.Keys.email: email, Constants.Keys.oldpassword: oldPassword, Constants.Keys.password: password ] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.changePassAPI)
        //print("UrlLink = \(urlLink)")
        
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

                completion(.Success(message))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    
    
}
