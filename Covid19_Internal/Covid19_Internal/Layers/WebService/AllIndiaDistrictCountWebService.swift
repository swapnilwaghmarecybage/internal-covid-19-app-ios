//
//  DistrictWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllIndiaDistrictCountWebService {
    
   static func callDistrictWebService(completion:@escaping (Bool, [Any]?)->()) {
        
        let request = Request(withURL: API.district)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
            AllDistrictsCountParser.parse { (arrayDictrictsModels) in
                completion(arrayDictrictsModels != nil ? true : false, arrayDictrictsModels)
            }
        }
        
        request.failureHandler = { (_ responseData : Data?, _ httpResponse: HTTPURLResponse?) -> Void in
            completion(false, nil)
        }
        
        let connection =  ConnectionManager.sharedInstance
        connection.start(request: request)
        
    }
}
