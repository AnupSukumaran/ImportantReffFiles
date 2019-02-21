//
//  APIService+Extension3.swift
//  EV Quiz
//
//  Created by Abraham VG on 06/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//



import Alamofire
import UIKit

extension APIService {
    
    //MARK: Upload profile pic
    func uploadProfilePic(image: UIImage, completion: @escaping(Results<String>) -> ()) {
        
        let email = UserDef.shared.email
        print("email = \(email)😄")
        let params = [Constants.Keys.email: email] as JSON
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.uploadPicPath)
        print("UrlLinkUpload = \(urlLink)")
        
        guard let profilePic = ProfilePicModel(withImage: image, forKey: Constants.Keys.photofile) else {
            return
        }
        
        Alamofire.upload(
            multipartFormData: {
                multipartFormData in
                
                for (key,value) in params {
                    multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                    
                }
                
                multipartFormData.append(profilePic.data , withName: profilePic.key, fileName: profilePic.filename ,mimeType: profilePic.mimeType)
        }, to: urlLink, method: .post, headers: nil, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let jsonResponse = response.result.value as? [String: Any] {
                        print("jsonResponse = \(jsonResponse)")
                        completion(.Success("File Uploaded"))
                        
                    }
                }
                
            case .failure(let encodingError):
                print("encodingError \(encodingError)")
                completion(.Error(encodingError.localizedDescription))
            }
        })
        
        
    }
    
    //MARK: Questions API - Get
    func questionsAPI(completion: @escaping(Results<ModelClassResponse>) -> ()) {
        
        let eventID = UserDef.shared.eventid
        let params = [Constants.Keys.eventid: eventID] as JSON
        let urlLink = URLFromParameters(params, pathExtension: Constants.pathExt.questionsPath)
        //print("UrlLink = \(urlLink)")
        
        let req = getRequestMaker(url: urlLink)
        
        Alamofire.request(req).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(.Error("Something went wrong!!.Please try again."))
                return
            }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? JSON else {print("jsonData😩");return}
            //    print("jasonData = \(jsonData)")
                let eventtime = jsonData[Constants.Keys.eventtime] as? String ?? "2019-01-01 00:00:00"
                let adstarttime = jsonData[Constants.Keys.adstarttime] as? String ?? "2019-01-01 00:00:00"
                
                gVal.INTROVIDEOSECS = CommonFuncs.shared.convertingGMTtoSec(adstarttime) - CommonFuncs.shared.convertingGMTtoSec(eventtime)
                print("gVal.INTROVIDEOSECS = \(gVal.INTROVIDEOSECS)")
                
                let adendtime = jsonData[Constants.Keys.adendtime] as? String ?? "2019-01-01 00:00:00"
                
                let adTotalSec = CommonFuncs.shared.convertingGMTtoSec(adendtime) - CommonFuncs.shared.convertingGMTtoSec(adstarttime)
                gVal.ADVIDEOSECS = adTotalSec == 0 ? 30 : adTotalSec
                print("gVal.ADVIDEOSECS = \(gVal.ADVIDEOSECS)")
                
                
                let startIntroTime = jsonData[Constants.Keys.introtimerstarttime] as? String ?? "2019-01-01 00:00:00"
                
                let endIntroTime = jsonData[Constants.Keys.introtimerendtime] as? String ?? "2019-01-01 00:00:00"
                
                let introTimerSec = CommonFuncs.shared.convertingGMTtoSec(endIntroTime) - CommonFuncs.shared.convertingGMTtoSec(startIntroTime)
                
                gVal.INTROTIMER = introTimerSec
                print("gVal.INTROTIMER = \(gVal.INTROTIMER)")
                
                let message = jsonData[Constants.Keys.message] as? String ?? "No message Found"
                guard let error = jsonData[Constants.Keys.error] as? String,  error == "0" else {completion(.Error(message));return}
                let classResponse = ModelClassResponse(json: jsonData)
                
                completion(.Success(classResponse))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
            }
        }
        
    }
    
    //MARK: Send Corrected Answers API
    func sendAnswersDetailsAPI(questID: String, ansID: String, correctAns: String, usedExtraLife: Bool, completion: @escaping(Results<String>) -> ()) {
        
        let eventID = UserDef.shared.eventid
        let userID = UserDef.shared.userid
   
        let params = [Constants.Keys.userid: userID, Constants.Keys.eventid: eventID, Constants.Keys.questionid: questID, Constants.Keys.answerid: ansID, Constants.Keys.correctanswer: correctAns, Constants.Keys.life: usedExtraLife ? "1":"0"] as JSON
        
        let urlLink = URLFromParameters([:], pathExtension: Constants.pathExt.answersPath)
 
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
