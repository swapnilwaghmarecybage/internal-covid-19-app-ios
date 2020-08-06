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
                 let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Array<CountryModel>.self, from: _responseData) //{
                       DispatchQueue.main.async {
                           completion(true, response)
                       }
                }catch {
                    print(error)
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
