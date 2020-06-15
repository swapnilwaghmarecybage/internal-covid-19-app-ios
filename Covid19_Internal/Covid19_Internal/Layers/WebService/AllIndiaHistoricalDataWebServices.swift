//
//  AllIndiaHistoricalDataWebServices.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation


struct AllIndiaHistoricalDataWebServices {
    
   static func callAllIndiaHitoricalDataWebService(completion:@escaping (Bool,[Any]?)->()) {
        
        let request = Request(withURL: API.all_india_historical_data)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
            AllIndiaHistoricalDataParser.parse { (arrayHistoricalDataModels) in
                completion(arrayHistoricalDataModels != nil ? true:false , arrayHistoricalDataModels)
            }
            
        }
        
        request.failureHandler = { (_ responseData : Data?, _ httpResponse: HTTPURLResponse?) -> Void in
            completion(false, nil)
        }
        
        let connection =  ConnectionManager.sharedInstance
        connection.start(request: request)
        
    }
}
