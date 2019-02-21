//
//  APIService+Extension7.swift
//  EV Quiz
//
//  Created by Abraham VG on 03/11/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


import Alamofire
import UIKit


extension APIService {
    
    //MARK: RESEND API - POST
    func resendAPI(email: String,completion: @escaping(Results<String>) -> ()) {
        
        let params = [Constants.Keys.email: email] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.resendOtpPath)
        print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            print("resendAPI is called")
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
    
    //MARK  cashout API  - POST
    func cashOutAPI(email: String, cashouttype: String, cashoutamount: String, fullname: String, payemail: String, completion: @escaping(Results<String>) -> ()) {
        
        let params = [Constants.Keys.email: email, Constants.Keys.cashouttype: cashouttype, Constants.Keys.cashoutamount: cashoutamount, Constants.Keys.fullname: fullname, Constants.Keys.payemail: payemail] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.cashout)
        print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            print("resendAPI is called")
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
    
    //MARK Buy Extra lives from cashout - POST
    func extraLifeBuyingAPI(email: String, cashouttype: String, extralife: String, completion: @escaping(Results<String>) -> ()) {
        
        let params = [Constants.Keys.email: email, Constants.Keys.cashouttype: cashouttype, Constants.Keys.extralife: extralife] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.cashout)
        print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            print("resendAPI is called")
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
