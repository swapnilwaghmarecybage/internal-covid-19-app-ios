//
//  DistrictModel.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 6/24/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
/*
struct DistrictModel {
    
    var stateName:String?
    var stateCode: String?
    var districtData: [District]?
    
    struct District {
        var districtName: String?
        var notes: String?
        var active: Int?
        var confirmed: Int?
        var deceased: Int?
        var recovered: Int?
    }
    
    
}
*/

struct DistrictModel: Codable {
    var districtData: [String: CovidCount]?
    var statecode:String?
    
    
    struct CovidCount: Codable {
        var notes: String?
        var active: Int?
        var confirmed: Int?
        var deceased: Int?
        var recovered: Int?
        var delta: Delta?
        
        struct Delta: Codable {
            var confirmed: Int?
              var deceased: Int?
              var recovered: Int?
        }

        
        
    }

}
