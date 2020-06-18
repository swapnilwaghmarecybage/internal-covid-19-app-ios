//
//  WorldWebServiceParser.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//
/*
import Foundation

struct  WorldCountParser {

    static func parse(arrayOfWorldDataDictionaries:[Dictionary<String, Any>], completion: @escaping ([WorldCountModel]?)->())  {
        
            let arrayWorldModel:[WorldCountModel]? =
            arrayOfWorldDataDictionaries.map { (object: [String: Any]) -> WorldCountModel in
            var modelObject = WorldCountModel()
            modelObject.activeCases = object["Active Cases_text"] as? String
            modelObject.countryName = object["Country_text"] as? String
            modelObject.lastUpdate = object["Last Update"] as? String
            modelObject.newCases = object["New Cases_text"] as? String
            modelObject.totaCases = object["Total Cases_text"] as? String
            modelObject.totalDeaths = object["Total Deaths_text"] as? String
            modelObject.totalRecovered = object["Total Recovered_text"] as? String
                
            return modelObject
        }
        completion(arrayWorldModel)
    }
}
*/
