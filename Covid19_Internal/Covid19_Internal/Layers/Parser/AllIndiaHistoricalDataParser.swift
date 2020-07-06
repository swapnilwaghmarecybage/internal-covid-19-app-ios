//
//  AllIndiaHistoricalDataParser.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllIndiaHistoricalDataParser {
    
    static func parse(dictionaryOfIndiaHistoricalData:[String: Any], completion: @escaping (IndiaHistoryModel?)->())  {
      
        if let responseStatus = dictionaryOfIndiaHistoricalData["success"] as? Bool,   responseStatus == true {
            var indiaHistoryModel = IndiaHistoryModel()
            
            indiaHistoryModel.success = true
            indiaHistoryModel.lastRefreshed = dictionaryOfIndiaHistoricalData["lastRefreshed"] as? String
            indiaHistoryModel.lastOriginUpdate = dictionaryOfIndiaHistoricalData["lastOriginUpdate"] as? String
            
            if let totalData = dictionaryOfIndiaHistoricalData["data"] as? [Dictionary<String,Any>]{
                let arrayOfIndianHistoricalModels =  totalData.map { (object:[String: Any]) -> IndiaHistoryModel.DayWiseData in
                var modelObject = IndiaHistoryModel.DayWiseData()
                    modelObject.day = object["day"] as? String
                    
                    if let summaryObject = object["summary"] as? [String: Any]{
                        var summaryOfIndia = IndiaHistoryModel.DayWiseData.SummaryAllIndia()

                        summaryOfIndia.total = summaryObject["total"] as? Int
                        summaryOfIndia.confirmedCasesIndian = summaryObject["confirmedCasesIndian"] as? Int
                        summaryOfIndia.confirmedCasesForeign = summaryObject["confirmedCasesForeign"] as? Int
                        summaryOfIndia.confirmedButLocationUnidentified = summaryObject["confirmedButLocationUnidentified"] as? Int
                        summaryOfIndia.deaths = summaryObject["deaths"] as? Int
                        summaryOfIndia.discharged = summaryObject["discharged"] as? Int
                        summaryOfIndia.totalActive = (summaryOfIndia.total ?? 0) - (summaryOfIndia.discharged ?? 0)
                        modelObject.summaryAllIndia = summaryOfIndia
                    }
                if let regionArray = object["regional"] as? [Dictionary<String, Any>], regionArray.count > 0 {
                    let regions = regionArray.map { (object: [String: Any]) -> IndiaHistoryModel.DayWiseData.Region in
                        var regionObject = IndiaHistoryModel.DayWiseData.Region()
                        regionObject.loc = object["loc"] as? String
                        regionObject.confirmedCasesIndian = object["confirmedCasesIndian"] as? Int
                        regionObject.confirmedCasesForeign = object["confirmedCasesForeign"] as? Int
                        regionObject.discharged = object["discharged"] as? Int
                        regionObject.deaths = object["deaths"] as? Int
                        regionObject.totalConfirmed = object["totalConfirmed"] as? Int
                        regionObject.totalActive = (regionObject.totalConfirmed ?? 0) - (regionObject.discharged ?? 0)
                        regionObject.day = modelObject.day
                        return regionObject
                    }
                    modelObject.allRegions = regions.sorted(by: {$0.totalConfirmed ?? 0 > $1.totalConfirmed ?? 0})
                }
                 return modelObject
                }
                indiaHistoryModel.data = arrayOfIndianHistoricalModels
            }
            completion(indiaHistoryModel)
        } else {
            print("Received Fail in API response")
            completion(nil)
        }
    }
}
