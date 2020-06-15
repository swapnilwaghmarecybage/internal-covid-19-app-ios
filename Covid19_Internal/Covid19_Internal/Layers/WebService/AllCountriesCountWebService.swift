//
//  CountriesWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllCountriesCountWebService {
    
   static func callCountriesWebService(completion:@escaping (Bool, [Any]?)->()) {
        
        let request = Request(withURL: API.all_countries)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
  
            AllCountriesParser.parse { (arrayAllCountriesModels) in
                completion(arrayAllCountriesModels != nil ? true:false , arrayAllCountriesModels)
            }
            
        }
        
        request.failureHandler = { (_ responseData : Data?, _ httpResponse: HTTPURLResponse?) -> Void in
            completion(false, nil)
        }
        
        let connection =  ConnectionManager.sharedInstance
        connection.start(request: request)
        
    }
}
