//
//  ConvertDataToObject.swift
//  ImportantReffFiles
//
//  Created by Sukumar Anup Sukumaran on 21/02/19.
//  Copyright © 2019 TechTonic. All rights reserved.
//

import Foundation

class ConvertDataToObject {
    
    //MARK: func To make JSONSerialization objects
    class func convertDataToObject(_ data: Data, completionBlk: @escaping(Result<AnyObject>) -> ()) {
        
        var parsedResult: AnyObject! = nil
        
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            completionBlk(.Success(parsedResult))
        } catch let error  {
            completionBlk(.Error(error.localizedDescription))
        }
        
    }
}
