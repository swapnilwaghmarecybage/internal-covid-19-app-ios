//
//  CountriesWebService.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllCountriesCountWebService {
    
   static func callCountriesWebService(completion:@escaping (Bool, [CountryModel]?)->()) {
        
        let request = Request(withURL: API.all_countries)
        request.successHandler = {( _ responseData : Data?, _ httpResponse : HTTPURLResponse?) -> Void in
  
            if let _responseData = responseData {
                do{
                    if let arrayOfcountriesDictionary = try JSONSerialization.jsonObject(with: _responseData, options: .mutableContainers) as? [Dictionary<String, Any>]{
                        AllCountriesParser.parse(arrayOfCountriesDataDictionaries: arrayOfcountriesDictionary) { (arrayAllCountriesModels) in
                            completion(arrayAllCountriesModels != nil ? true:false , arrayAllCountriesModels)
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
