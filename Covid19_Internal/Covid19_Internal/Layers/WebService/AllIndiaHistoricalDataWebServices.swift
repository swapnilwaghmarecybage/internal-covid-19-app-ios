//
//  AllIndiaHistoricalDataWebServices.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation


struct AllIndiaHistoricalDataWebServices {
    
   static func callAllIndiaHitoricalDataWebService(completion:@escaping (Bool,IndiaHistoryModel?)->()) {
        
        let request = Request(withURL: API.all_india_historical_data)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
            if let _responseData = responseData {
                         do{
                            if let dictionaryOfIndiaHistoricalData = try JSONSerialization.jsonObject(with: _responseData, options: .mutableContainers) as? [String: Any]{
                                 
                                AllIndiaHistoricalDataParser.parse(dictionaryOfIndiaHistoricalData: dictionaryOfIndiaHistoricalData) { (indiaHistoryModel) in
                                     completion(indiaHistoryModel != nil ? true:false , indiaHistoryModel)
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
