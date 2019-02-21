//
//  APIMethods.swift
//  ImportantReffFiles
//
//  Created by Sukumar Anup Sukumaran on 21/02/19.
//  Copyright © 2019 TechTonic. All rights reserved.
//

import Foundation

class APIMethods: NSObject {
    
    var session = URLSession.shared
    
    
    func getMethod(request: URLRequest, completionBlk: @escaping(Result<AnyObject>) -> ()) -> URLSessionDataTask {
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {print("Error 😩");return}
            guard let data = data else {print("data😩");return}
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionBlk(.Error("Error :( status code -> \((response as! HTTPURLResponse).statusCode)"))
                return
            }
            
            ConvertDataToObject.convertDataToObject(data, completionBlk: completionBlk)
            
        }
        
        task.resume()
        
        return task
    }
    
    //MARK: func For Post Method
    func postMethod( request: URLRequest, jsonBody: String, completionBlk: @escaping(Result<AnyObject>) -> ()) -> URLSessionDataTask {
        
        var request = request
        request.httpMethod = "POST"
        request.httpBody = jsonBody.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {print("Error 😩");return}
            guard let data = data else {print("data😩");return}
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionBlk(.Error("Error :( status code -> \((response as! HTTPURLResponse).statusCode)"))
                return
            }
            
//            let range = Range(5..<data.count)
//            let newData = data.subdata(in: range)
            
            ConvertDataToObject.convertDataToObject(data, completionBlk: completionBlk)
            
        }
        task.resume()
        
        return task
    }
    
    
    func putMethod( request: URLRequest, jsonBody: String, completionBlk: @escaping(Result<AnyObject>) -> ()) -> URLSessionDataTask {
        
        
        var request = request
        request.httpMethod = "PUT"
        
        
        request.httpBody = jsonBody.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {print("Error 😩");return}
            guard let data = data else {print("data😩");return}
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionBlk(.Error("Error :( status code -> \((response as! HTTPURLResponse).statusCode)"))
                return
            }
            
            ConvertDataToObject.convertDataToObject(data, completionBlk: completionBlk)
            
        }
        task.resume()
        
        return task
    }
    
    
    
}
