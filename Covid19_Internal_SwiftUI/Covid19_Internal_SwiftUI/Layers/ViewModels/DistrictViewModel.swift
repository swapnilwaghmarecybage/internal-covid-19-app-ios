//
//  DistrictViewModel.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 8/1/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class DistrictViewModel: Identifiable {
    
    let id = UUID()
    let districtName:String
    let cases: DistrictModel.CovidCount
    
    init(_name:String,_cases: DistrictModel.CovidCount) {
        self.districtName = _name
        self.cases = _cases
    }
    var name: String {
        return districtName
    }
    
    var active: Int {
        return cases.active ?? 0
    }
    var notes: String {
        return cases.notes ?? ""
    }
    var confirmed: Int{
        return cases.confirmed ?? 0
    }
    var deceased: Int{
        return cases.deceased ?? 0
    }
    var recovered: Int {
        return cases.recovered ?? 0
    }
    var delta_Confirmed: Int {
        return cases.delta?.confirmed ?? 0
    }
    var delta_recovered: Int {
        return cases.delta?.recovered ?? 0
    }
    var delta_deceased: Int {
        return cases.delta?.deceased ?? 0
    }    
}

