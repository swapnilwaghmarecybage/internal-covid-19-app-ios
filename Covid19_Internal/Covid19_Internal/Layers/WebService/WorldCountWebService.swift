//
//  WorldWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//
/*

import Foundation

struct WorldCountWebService {
    
   static func callWorldCountWebService(completion:@escaping (Bool, [WorldCountModel]?)->()) {
        
        let request = Request(withURL: API.world_count)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
           
            if let _responseData = responseData {
                do{
                    if let arrayofWorldDictionary = try JSONSerialization.jsonObject(with: _responseData, options: .mutableContainers) as? [Dictionary<String, Any>]{
                        WorldCountParser.parse(arrayOfWorldDataDictionaries: arrayofWorldDictionary) { (worldDataModelObject) in
                            completion(worldDataModelObject != nil ?true:false ,worldDataModelObject)
                        }
                    }

                } catch {
                    print("Exception : ")
                    completion(false, nil)
                }
            }
        }
        
        request.failureHandler = { (_ responseData : Data?, _ httpResponse: HTTPURLResponse?) -> Void in
            completion(false, nil)
        }
        
        let connection =  ConnectionManager.sharedInstance
        connection.start(request: request)
        
    }
}
*/
