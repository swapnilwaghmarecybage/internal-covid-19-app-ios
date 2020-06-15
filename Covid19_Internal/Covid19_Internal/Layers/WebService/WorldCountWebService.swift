//
//  WorldWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct WorldCountWebService {
    
   static func callWorldCountWebService(completion:@escaping (Bool, Any?)->()) {
        
        let request = Request(withURL: API.world_count)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
            WorldCountParser.parse { (worldData) in
                completion(worldData != nil ?true:false ,worldData)
            }
            
        }
        
        request.failureHandler = { (_ responseData : Data?, _ httpResponse: HTTPURLResponse?) -> Void in
            completion(false, nil)
        }
        
        let connection =  ConnectionManager.sharedInstance
        connection.start(request: request)
        
    }
}
