//
//  StateViewModel.swift
//  Covid19_Internal_SwiftUI
//
//  Created by Swapnil Waghm on 7/29/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation

class StateViewModel: Identifiable {
    
    let id = UUID()
    
    let data: IndiaHistoryModel.DayWiseData.Region
    
    init(_data: IndiaHistoryModel.DayWiseData.Region) {
        self.data = _data
    }
    
    var loc: String {
        return data.loc ?? ""
    }
    
    var confirmedCasesIndian: Int {
        return data.confirmedCasesIndian ?? 0
    }
    
    var confirmedCasesForeign: Int {
        return data.confirmedCasesForeign ?? 0
    }
    
    var discharged: Int {
        return data.discharged ?? 0
    }
    var deaths: Int {
        return data.deaths ?? 0
    }
    var totalConfirmed: Int {
        return data.totalConfirmed ?? 0
    }
    
    var active: Int {
        if let _total = data.totalConfirmed, let _discharged = data.discharged, let _deaths = data.deaths{
            return _total - (_discharged + _deaths)
        }
        return 0
    }
    
}
