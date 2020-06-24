//
//  DistrictWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllIndiaDistrictCountWebService {
    
   static func callDistrictWebService(completion:@escaping (Bool, [DistrictModel]?)->()) {
        
        let request = Request(withURL: API.district)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
            
            if let _responseData = responseData {
                         do{
                            if let dictionaryOfDistrictData = try JSONSerialization.jsonObject(with: _responseData, options: .mutableContainers) as? [String: Any]{
                                 
                                AllDistrictsCountParser.parse(dictionaryOfAllStatesOfIndia: dictionaryOfDistrictData) { (arrayDictrictsModels) in
                                     completion(arrayDictrictsModels != nil ? true : false, arrayDictrictsModels)
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
