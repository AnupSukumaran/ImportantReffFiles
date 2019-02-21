//
//  APIService.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
   static let shared = APIService()
    let resumeCache = NSCache<NSString, NSData>()
    var backgroundSessionCompletionHandler: (() -> Void)?
    
   let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        let eventid = UserDef.shared.eventid
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentsURL.appendPathComponent("\(gVal.ADVIDEOID).mp4")
        return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
    }

     lazy var backgroundManager: Alamofire.SessionManager? = {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {print("bundleIdentifier😩");return nil}
        return Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: bundleIdentifier + ".background"))
    }()
    
    func getRequestMaker(url: URL) -> URLRequest {
        
        
        var req = URLRequest(url: url)
        req.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        req.httpMethod = "GET"
        
        return req
    }
  
    
    func URLFromParameters(_ parameters: [String:AnyObject], pathExtension: String?) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath + (pathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    //MARK: loginAPI - POST
    func loginAPI(email: String, password: String, completion: @escaping(Results<ModelClassResponse>) -> ()) {
    
        
        let params = [Constants.Keys.email: email, Constants.Keys.password : password, Constants.Keys.tokenid: gVal.uniqueDeviceID, Constants.Keys.uaeapp: Constants.APPTYPE] as JSON
        
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.loginAPI)
        
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            
            switch response.result {
            case .success(let data):
            
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
                print("jsonData = \(jsonData)😄")
                
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                
//                guard let error2 = jsonData[Constants.Keys.error] as? String,  error2 != "2" else {
//
//                    completion(.Error("2"));return
//
//                }
                
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {
                    
                    if let error = jsonData[Constants.Keys.error] as? String, error == "2" {
                        completion(.Error("2"));return
                    } else {
                        completion(.Error(message));return
                    }
                    
                    
                }
                
                
                let classResponse = ModelClassResponse(json: jsonData)
                completion(.Success(classResponse))
                
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: registerAPI - POST
    func registerAPI(email: String, password: String, completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
//        let params = [Constants.Keys.email: email  , Constants.Keys.password : password, Constants.Keys.tokenid: gVal.uniqueDeviceID] as JSON
        
        let params = [Constants.Keys.email: email  , Constants.Keys.password : password, Constants.Keys.tokenid: gVal.uniqueDeviceID, Constants.Keys.uaeapp: Constants.APPTYPE] as JSON
        
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.registerAPI)
        // print("URLLINK = \(urlLink)")
        
        Alamofire.request(urlLink, method: .post, parameters: params).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            
            switch response.result {
            case .success(let data):
                
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
               // print("JAsonData = \(jsonData)")
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let classResponse = ModelClassResponse(json: jsonData)
               // let message = classResponse.registerModel.first?.message ?? "No Message Found"
               // guard classResponse.registerModel.first?.error == "0" else {completion(.Error(message));return}
                completion(.Success(classResponse))
                
            case .failure(_):
                completion(.Error(Constants.serErrorMsg))
            }
        }
        
    }
    
    //MARK: OTP - otpAPI - POST
    func otpAPI(email: String, otp: String, completion: @escaping(Results<ModelClassResponse>) -> ()) {
//        let email = UserDef.shared.email
//        print("email = \(email)😄")
        gVal.otp = otp
        let params = [Constants.Keys.email: email  , Constants.Keys.otp : otp] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.otpAPI)
        //print("UrlLink = \(urlLink)")
        
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
               // let message = classResponse.otpModel.first?.message ?? "No Message Found"
//                guard classResponse.otpModel.first?.error == "0" else {completion(.Error(message));return}
                completion(.Success(classResponse))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
    }
    
   
}

