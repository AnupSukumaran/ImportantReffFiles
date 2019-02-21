//
//  APIService+Extension5.swift
//  EV Quiz
//
//  Created by Sukumar Anup Sukumaran on 21/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Alamofire
import UIKit

enum DLResults<T> {
    case getDouble(Double)
    case comp(String)
}



//enum Results<T> {
//    case Success(T)
//    case Error(String)
//}

extension APIService {

    //MARK: DOWNLOAD VIDEO
    func downloadVideo(completion: @escaping(DLResults<Double>) -> ()) {

       // let eventid = UserDef.shared.eventid
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.introPath + "\(gVal.ADVIDEOID).mp4")
        
        backgroundManager?.startRequestsImmediately = true
        let request = URLRequest(url: urlLink)
        backgroundManager?.download(request, to: destination).downloadProgress { (progress) in
            print("progress = \(progress.fractionCompleted)😄")
            let progressDouble = progress.fractionCompleted
            completion(.getDouble(progressDouble))
            
            }.response { (response) in
                
                
            }.responseJSON { (response) in
                if response.result.error == nil {
                    gVal.introVideoURL = response.destinationURL
                    completion(.comp("Completed"))
                } else {
                    print("Error While Downloading 😩")
                    gVal.introVideoURL = response.destinationURL
                    completion(.comp("Error"))
                }
        }

        
    }
    
    //MARK: RESET PASSWORD API - ResetPassword API
    func resetPasswordAPI(email: String, newPassword: String, completion: @escaping(Results<String>) -> ()) {
        
        let params = [Constants.Keys.email: email, Constants.Keys.otp: gVal.otp, Constants.Keys.newpassword: newPassword ] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.resetPassPath)
      //  print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
          
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
              //  print("JAsonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                completion(.Success("New Password Created"))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
    }
    
    //MARK: MEDALS API - Medals API
    func medalsAPI(completion: @escaping(Results<ModelClassResponse>) -> ()) {
        let userid = UserDef.shared.userid
        let params = [Constants.Keys.userid: userid] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.userMedalsPath)
      //  print("UrlLink = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
               // print("jasonData = \(jsonData)")
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
