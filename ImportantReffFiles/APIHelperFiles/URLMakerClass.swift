//
//  URLMakerClass.swift
//  ImportantReffFiles
//
//  Created by Sukumar Anup Sukumaran on 21/02/19.
//  Copyright © 2019 TechTonic. All rights reserved.
//

import Foundation

class URLMakerClass {
    
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
    
}
