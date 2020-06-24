//
//  AllDistrictsWebServiceDataParser.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/15/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

struct AllDistrictsCountParser {
 
    static func parse(dictionaryOfAllStatesOfIndia:[String: Any],completion: @escaping ([DistrictModel]?)->())  {
         var arrayOfDistrictModels = [DistrictModel]()
        for (key, value) in dictionaryOfAllStatesOfIndia {
            var object = DistrictModel()
            object.stateName = key
            object.districtData = [DistrictModel.District]()
            if let valueOfStateKey = value as? [String: Any]{
                object.stateCode = valueOfStateKey["statecode"] as? String
                if let allDistrictsDictionary = valueOfStateKey["districtData"] as? [String:Any]{
                     var singleDistrict = DistrictModel.District()
                    
                    for (key, value) in allDistrictsDictionary {
                        singleDistrict.districtName = key
                        if let district = value as? [String:Any]{
                            singleDistrict.active = district["active"] as? Int
                            singleDistrict.confirmed = district["confirmed"] as? Int
                            singleDistrict.deceased = district["deceased"] as? Int
                            singleDistrict.recovered = district["recovered"] as? Int
                            singleDistrict.notes = district["notes"] as? String
                        }
                        object.districtData?.append(singleDistrict)
                    }
                }
               
            }
            arrayOfDistrictModels.append(object)
        }
        completion(arrayOfDistrictModels)
    }
    
}
